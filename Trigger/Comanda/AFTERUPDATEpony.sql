/* QUI C’E DA CORREGGERE L’AGGIORNA PONY  DA AGGIUNGERCI L EVENT*/

DROP TRIGGER IF EXISTS AssegnaPony;
DELIMITER $$
CREATE TRIGGER AssegnaPony
AFTER UPDATE ON Comanda FOR EACH ROW 

BEGIN 

IF ( New.TipoTakeAway = 1 AND New.Stato = "Evasa" ) THEN

SET @NumeroPiatti = ( SELECT 
							SUM(Quantita)
					  FROM
							Ordine
					  WHERE
							IdComanda = New.IDComanda ); 

IF ( @NumeroPiatti > 5 ) THEN
	SET @CercaMezzo = 4;
ELSE
	SET @CercaMezzo = 2;
END IF; 

SET @PonyAssegnato = NULL;
SET @PonyAssegnato = ( SELECT 
							IDPony
						FROM
							Pony P INNER JOIN comandatakeaway CTA USING (IdSede)
						WHERE
							Stato = 'Libero'  AND Mezzo = @CercaMezzo AND CTA.IDComandaTA=New.IdComanda
                        LIMIT 1 );
IF ( @PonyAssegnato IS NULL ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Non ci sono Pony attualmente disponibili per la consegna';
ELSE

UPDATE ComandaTakeAway
SET 
	Pony = @PonyAssegnato
WHERE IDComandaTA = NEW.IDComanda;

UPDATE Pony 
SET 
    Stato = 'Occupato'
WHERE IDPony = @PonyAssegnato;

END IF;

END IF;

END $$

DELIMITER ;

