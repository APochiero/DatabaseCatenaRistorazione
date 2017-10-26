DROP TRIGGER IF EXISTS GestisciTimeStampComandaTA;
DELIMITER $$
CREATE TRIGGER GestisciTimestampComandaTA
AFTER UPDATE ON Pony FOR EACH ROW
BEGIN

/* IL TRIGGER SCATTA SOLO SE C'E UN CAMBIO DI STATO  */
IF (OLD.IdPony=NEW.IdPony AND OLD.SedePony=New.SedePony AND OLD.Mezzo=New.Mezzo) THEN


SET @Comanda_ = ( Select IDComandaTA
				  FROM ComandaTakeAway
                  WHERE Pony = New.IDPony AND 
                  NEW.SedePony=IdSede AND 
                  Time_stampRientro IS NULL );
                  
                  

/* CASO IN CUI IL PONY STA PARTENDO */
IF ( NEW.Stato = "Occupato" ) THEN
	
 CREATE TEMPORARY TABLE IF NOT EXISTS  ComandeDaConsegnare
(
IdComandaTA VARCHAR(6),
Time_Stamp TimeStamp ,
IdSede VARCHAR(6),
NumPiatti int DEFAULT 0,
PRIMARY KEY (IdComandaTA)
);  
  
  
SET @NuovaComanda=NULL;
SET @NuovaComanda= (SELECT IdComandaTA
					FROM ComandeDaConsegnare
                    WHERE New.SedePony=IdSede
					ORDER BY Time_stamp
                    LIMIT 1);
SET @NumeroPiatti = (SELECT IdComandaTA
					FROM ComandeDaConsegnare
                    WHERE New.SedePony=IdSede
					ORDER BY Time_stamp
                    LIMIT 1);
 /* CONTROLLA SE E' IL MEZZO GIUSTO CON CUI PORTARE I PIATTI */                   
IF ( @NumeroPiatti > 5 ) THEN
	SET @CercaMezzo = 4;
ELSE
	SET @CercaMezzo = 2;
END IF; 
   /* SE NON CI SONO COMANDE PER QUEL TIPO DI MEZZO IN QUELLA SEDE E' LIBERO
   ALTRIMENTI PRENDE LA PRIMA DA CONSEGNARE E LA PORTA */
/* IL MAGGIORE= E' DOVUTO AL FATTO CHE SE SI LIBERA PRIMA UNA MACCHINA E SI HA UN CARICO DA
SCOOTER LO PORTA LO STESSO LA MACCHINA */
IF (@NuovaComanda IS NOT NULL AND NEW.Mezzo>=@CercaMezzo ) 
THEN

/* ELIMINA LA COMANDA NEL PARZIALE DELLE COMANDE DA CONSEGNARE */
DELETE FROM ComandeDaConsegnare 
WHERE IdComandaTA=@NuovaComanda;

/* AGGIORNA IL VERO TIMESTAMP DI PARTENZA */

UPDATE ComandaTakeAway 
SET Time_stampPartenza = CURRENT_TIMESTAMP,
Pony = NEW.IDPony
WHERE  IDComandaTA = @NuovaComanda;

ELSE
    
    /* NON CI SONO ORDINI IN CODA ASSEGNA DIRETTAMENTE */
    UPDATE ComandaTakeAway
	SET Time_stampPartenza = CURRENT_TIMESTAMP 
	WHERE Pony = NEW.IDPony AND IDComandaTA = @Comanda_ ;


END IF;


END IF;

END IF;
END$$

DELIMiTER ;
