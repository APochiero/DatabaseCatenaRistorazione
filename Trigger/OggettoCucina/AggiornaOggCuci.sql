DROP TRIGGER IF EXISTS ControllaOggetto1;
DELIMITER $$
CREATE TRIGGER ControllaOggetto1
BEFORE UPDATE ON OggettoCucina FOR EACH ROW

BEGIN
IF (NEW.Tipo <> 'Macchinario' AND NEW.Tipo <> 'Attrezzatura') then

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT ='Tipo Inserito Non corretto solo Macchinario O Attrezzatura';
END IF;  

IF (NEW.stato <> 'Disponibile' AND NEW.stato <> 'In Uso' AND NEW.stato <> 'Guasto') then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT ='Tipo Stato Non corretto solo Disponibile/In Uso/Guasto';
END IF; 

 
/* ------------------------------------------------------------------------------------------------------------------- */
IF ( OLD.Stato = "In Uso" AND NEW.Stato = "Disponibile" ) THEN

	SET @OrdineDaMandareAvanti = ( 	SELECT IDOrdine					
									FROM Temp_OrdinePriorita
									WHERE IDOggetto = NEW.IDOggetto );

	DELETE FROM Temp_OrdinePriorita 		/*INCREMENTO DEL PROCEDIMENTOSTEP*/
	WHERE IDOrdine = @OrdineDaMandareAvanti
		AND IDOggetto = NEW.IDOggetto;

	

/*GESTIONE ORDINE CHE DEVE CONTINUARE IL PROCEDIMENTOSTEP*/
	SET @Priorita = ( 	SELECT Priorita  
						FROM Temp_OrdinePriorita
						WHERE IDOrdine = @OrdineDaMandareAvanti
						ORDER BY Priorita
						LIMIT 1 );
 
	IF ( @Priorita IS NULL ) THEN /* ORDINE TERMINATO */
	
		UPDATE Ordine
		SET Stato = 'Servizio'
		WHERE IDOrdine = @OrdineDaMandareAvanti;
    
	ELSE /* CI SONO ANCORA FASI DELL'ORDINE DA PREPARARE */
		
		SET @OggettoDisponibile = ( SELECT OC.IDOggetto
								FROM Temp_OrdinePriorita Temp INNER JOIN Fase  F ON F.IDFase = Temp.IDFase
									INNER JOIN UtilizzoFase UF ON F.IDFase = UF.IDFase 
									INNER JOIN OggettoCucina OC ON OC.IDOggetto = UF.IDOggetto 
								WHERE OC.Stato = 'Disponibile' AND Temp.IDOrdine = @OrdineDaMandareAvanti AND IDSede = @IdSede AND Priorita = @Priorita
                                LIMIT 1 );                  
		IF ( @OggettoDisponibile IS NOT NULL ) THEN

			UPDATE Temp_OrdinePriorita
			SET IDOggetto = @OggettoDisponibile
			WHERE IDOrdine = @OrdineDaMandareAvanti AND Priorita = @Priorita;

			SET @Quantita = (   SELECT Quantita
								FROM Ordine 
								WHERE IDOrdine = @OrdineDaMandareAvanti );
			ELSE 
				INSERT INTO _CodaOrdini 
			SELECT 
				IDordine, IDFase, current_timestamp()
			FROM
				Temp_OrdinePriorita
			WHERE IDOrdine = @OrdineDaMandareAvanti AND Priorita = @Priorita;
		
		END IF;
	END IF;

 /* --------------------------------------------------------------------------------------------------------------------------- */                   
	/*GESTIONE ORDINE IN CODA*/

	/*CERCO UN ORDINE NELLA CODA DEGLI ORDINI A CUI POTREBBE ESSERE UTILE L'OGGETTO CHE E' APPENA DIVENTATO DISPONIBILE */
	SET @CercaOrdine = (	SELECT IDOrdine		
							FROM _CodaOrdini INNER JOIN UtilizzoFase USING (IDFase)
							WHERE IDOggetto = NEW.IDOggetto 
							ORDER BY Time_Stamp
							LIMIT 1 );

	IF ( @CercaOrdine IS NOT NULL ) THEN  /*SE ESISTONO ORDINI CHE ERANO IN CODA A CAUSA DI UNA FASE SVOLTA DA NEW.IDOGGETTO, 
										ALLORA ASSEGNA L'OGGETTO ALL'ORDINE CHE HA IL TIMESTAMP MINORE ( IN CODA DA PIU' TEMPO )*/

		SET @Priorita =( 	SELECT Priorita
							FROM Temp_OrdinePriorita
							WHERE IDOrdine = @CercaOrdine
							ORDER BY Priorita
							LIMIT 1 );
		
		IF ( @Priorita = 1 ) THEN /* SI PREPARA LA PRIMA FASE DELL'ORDINE QUINDI ENTRA IN PREPARAZIONE */
			UPDATE Ordine
			SET Stato = 'InPreparazione'
			WHERE IDOrdine = @CercaOrdine;
            
            SET @Quantita = ( 	SELECT Quantita 
								FROM Ordine 
								WHERE IDOrdine = @CercaOrdine );
            
            CALL AggiornaConfezioni( @IdSede, @CercaOrdine, @Quantita );
            
		END IF;
        
		UPDATE Temp_OrdinePriorita 
		SET 
			IDOggetto = NEW.IDOggetto
		WHERE
			IDOrdine = @CercaOrdine
		AND Priorita = @Priorita;
	
    /*ELIMINO L'ORDINE DALLA CODA */
		DELETE FROM _CodaOrdini 
		WHERE
			IDOrdine = @CercaOrdine;
	END IF;
END IF;
END $$
DELIMITER ;