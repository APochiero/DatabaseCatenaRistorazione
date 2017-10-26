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
/* ASSEGNA ALLA COMANDA IN BASE AL NUMERO DI PIATTI */
SET @PonyAssegnato = NULL;
SET @PonyAssegnato = ( SELECT 
							IDPony
						FROM
							Pony P INNER JOIN comandatakeaway CTA ON P.SedePony=CTA.IdSede
						WHERE
							Stato = 'Libero'  AND 
                            Mezzo = @CercaMezzo AND
                            CTA.IDComandaTA=New.IdComanda
                        LIMIT 1 );
                      
/* SE NON CI FOSSERO MOTORINI MA CE ALMENO UNA MACCHINA ALLORA LI CONSEGNA CON QUELLA
E NON STA AD ASPETTARE CHE TORNI APPOSTA IL MOTORINO */                        
IF ( @CercaMezzo=2 AND @PonyAssegnato IS NULL) then
SET @PonyAssegnato = ( SELECT 
							IDPony
						FROM
							Pony P INNER JOIN comandatakeaway CTA ON P.SedePony=CTA.IdSede
						WHERE
							Stato = 'Libero'  AND 
                            Mezzo = 4 AND
                            CTA.IDComandaTA=New.IdComanda
                        LIMIT 1 );

END IF;                       
                        
                        
                        
IF ( @PonyAssegnato IS NULL ) THEN


CREATE TEMPORARY TABLE IF NOT EXISTS ComandeDaConsegnare
(
IdComandaTA VARCHAR(6),
Time_Stamp TimeStamp ,
IdSede Varchar(6),
NumPiatti int DEFAULT 0,
PRIMARY KEY (IdComandaTA)

);
SET @sede=( SELECT CTA.IdSede
			FROM ComandaTakeAway CTA
            WHERE CTA.IdComandaTA=New.IdComanda);
INSERT INTO ComandeDaConsegnare VALUES (NEW.IdComanda,New.Time_Stamp,@sede,@NumeroPiatti);


ELSE



UPDATE ComandaTakeAway
SET  Pony = @PonyAssegnato
WHERE IDComandaTA = NEW.IDComanda;



UPDATE Pony 
SET Stato = 'Occupato'
WHERE IDPony = @PonyAssegnato;

END IF;

END IF;

END $$

DELIMITER ;

