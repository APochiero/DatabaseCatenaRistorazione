DROP TRIGGER IF EXISTS InserimentoOrdine;

DELIMITER $$
CREATE TRIGGER InserimentoOrdine
BEFORE INSERT ON Ordine FOR EACH ROW

BEGIN

IF (NEW.Quantita<=0) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La quantita inserita non può essere minore uguale di 0 ';

END IF;


IF (NEW.Stato<>'Attesa' AND NEW.Stato<>'InPreparazione' AND NEW.Stato<>'Servizio' AND NEW.Stato <> 'InElaborazione') THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Lo stato inserito non è valido ';
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

SET @Conta=(
SELECT COUNT(*)
FROM mv_elencopiattiordinabili EPO
WHERE EPO.IdSede=@idsede AND EPO.IdPiatto=NEW.IdPiatto
);

IF (@Conta=0) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'Spiacenti impossibile ordinare il piatto abbiamo finito gli ingredienti ';
END IF;


IF ( NEW.Variazione = 0 ) THEN

	INSERT INTO Temp_OrdinePriorita                 
	SELECT NEW.IDOrdine, Priorita, NULL, IDIngrediente, Dose_gr, IDFase, Principale
	FROM Procedimentostep  
	WHERE IDPiatto = NEW.IDPiatto; 

	UPDATE comanda
    SET TempoStimato = TempoStimato + ( SELECT SUM(Tempo_sec)
						 FROM ProcedimentoStep
                         WHERE IDPiatto = NEW.IDPiatto
                         GROUP BY IDPiatto )
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
          
		UPDATE Comanda
        SET Stato = 'InPreparazione'
        WHERE IDComanda = NEW.IDComanda;
        
	ELSE 
		INSERT INTO _CodaOrdini 
		SELECT 
			NEW.IDOrdine, IDFase, current_timestamp()
		FROM
			Temp_OrdinePriorita
		WHERE IDOrdine = NEW.IDOrdine AND Priorita = 1;
	END IF;
ELSE
	SET NEW.Stato = 'InElaborazione';
    
   
END IF;

END $$
DELIMITER ;
