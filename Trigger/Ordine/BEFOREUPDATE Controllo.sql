/* CONTROLLO CHE SIA STATO FATTO AGGIORNAMENTO SENSATO SU ORDINE */
 
DROP TRIGGER IF EXISTS AggiornaOrdine;
DELIMITER $$
CREATE TRIGGER AggiornaOrdine
BEFORE UPDATE ON Ordine FOR EACH ROW

BEGIN

IF (NEW.Stato<>'Attesa' AND NEW.Stato<>'InPreparazione' AND NEW.Stato<>'Servizio' AND NEW.Stato <> 'InElaborazione' ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Lo stato inserito non è valido ';
END IF;



IF (NEW.Quantita<=0) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La quantita inserita non può essere minore uguale di 0 ';
END IF;


IF (NEW.Stato <>'Attesa' AND 
(NEW.Quantita<>OLD.Quantita OR New.Variazione<> OLD.Variazione 
OR NEW.IdPiatto<>Old.IdPiatto) ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='TROPPO TARDI PER POTER MODIFICARE L ORDINE LO STATO DEVE ESSERE ATTESA ';
END IF;


IF (NEW.Variazione<>0 AND NEW.Variazione <>1 ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La variazione può valere solo 0 o 1';
END IF;

SET @tipo= ( SELECT C.TipoTakeAway
				FROM  Comanda C
				WHERE  C.IdComanda=NEW.IdComanda);

IF (@tipo = 0) then

	SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN Tavolo Using (IdTavolo)
                INNER JOIN Sala Sa USING (IdSala)
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=NEW.IdComanda);
else

	SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN ComandaTakeAway CTA on C.IdComanda=CTA.IdComandaTA
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=NEW.IdComanda);
END IF;

IF ( OLD.Stato = 'InElaborazione' AND NEW.Stato = 'Attesa' ) THEN 

	INSERT INTO Temp_OrdinePriorita 
    SELECT  NEW.IDOrdine, Priorita, NULL, Ingrediente, NuovaDose, Fase, Principale
	FROM ProcedimentoStep PR INNER JOIN ContieneVariazione CV USING (IDVariazione) INNER JOIN Variazione USING (IDVariazione)
	WHERE IDPiatto = NEW.IDPiatto AND PR.IDvariazione = CV.IDVariazione AND CV.IDOrdine = NEW.IDOrdine
	UNION 
	SELECT NEW.IDOrdine, Priorita, NULL, IDIngrediente, Dose_gr, IDFase,Principale
	FROM ProcedimentoStep PR 
	WHERE IDPiatto = NEW.IDPiatto AND ( PR.IDVariazione IS NULL OR  IDVariazione NOT IN (  SELECT IDVariazione
																						FROM contienevariazione	CV
																						WHERE IDOrdine = NEW.IDOrdine ) );
                                                                                        
	UPDATE Comanda
    SET TempoStimato = TempoStimato + ( 	SELECT SUM(tempo)
											FROM 
												(   SELECT NuovoTempo AS TEMPO
													FROM ProcedimentoStep PR INNER JOIN ContieneVariazione CV USING (IDVariazione) INNER JOIN Variazione USING (IDVariazione)
													WHERE IDPiatto = NEW.IDPiatto AND PR.IDvariazione = CV.IDVariazione AND CV.IDOrdine = NEW.IDOrdine
													UNION 
													SELECT Tempo_sec AS TEMPO
													FROM ProcedimentoStep PR 
													WHERE IDPiatto = NEW.IDPiatto AND PR.IDVariazione IS NULL OR  IDVariazione NOT IN (  SELECT IDVariazione
																																		FROM contienevariazione	CV
																																		WHERE IDOrdine = NEW.IDOrdine ) ) AS D )
	WHERE IDComanda = NEW.IDComanda;

	SET @OggettoDisponibile = (	SELECT OC.IDOggetto
								FROM Temp_OrdinePriorita Temp INNER JOIN Fase  F ON F.IDFase = Temp.IDFase
									INNER JOIN UtilizzoFase UF ON F.IDFase = UF.IDFase 
									INNER JOIN OggettoCucina OC ON OC.IDOggetto = UF.IDOggetto 
								WHERE OC.Stato = 'Disponibile' AND Temp.IDOrdine = NEW.IDOrdine AND IDSede = @IdSede AND Priorita = 1
                                LIMIT 1); 
                                
	IF ( @OggettoDisponibile IS NOT NULL ) THEN

		SET NEW.Stato = 'InPreparazione';
        
		UPDATE Temp_OrdinePriorita
		SET IDOggetto = @OggettoDisponibile
		WHERE IDOrdine = NEW.IDOrdine AND Priorita = 1;

		UPDATE OggettoCucina
		SET Stato = 'In Uso'
		WHERE IDOggetto = @OggettoDisponibile;
			
		CALL AggiornaConfezioni( @IDSede, NEW.IDOrdine, NEW.Quantita );
	ELSE 
			INSERT INTO _CodaOrdini 
			SELECT 
				NEW.IDOrdine, IDFase, current_timestamp()
			FROM
				Temp_OrdinePriorita
			WHERE IDOrdine = NEW.IDOrdine AND Priorita = 1;
	END IF;
END IF;
END $$

DELIMITER ;
