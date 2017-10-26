DELIMITER $$

CREATE TRIGGER GestisciTimestampComandaTA
AFTER UPDATE ON Pony FOR EACH ROW

BEGIN

SET @Comanda_ = ( Select IDComandaTA
				  FROM ComandaTakeAway
                  WHERE Pony = New.IDPony AND Time_stampRientro IS NULL );


IF ( NEW.Stato = "Occupato" ) THEN
	UPDATE ComandaTakeAway
	SET Time_stampPartenza = CURRENT_TIMESTAMP 
	WHERE Pony = NEW.IDPony AND IDComandaTA = @Comanda_ ;
END IF;

IF ( NEW.Stato = "Libero" ) THEN
	UPDATE ComandaTakeAway
    SET Time_stampRientro = CURRENT_TIMESTAMP
    WHERE Pony = NEW.IDPony AND IDComandaTA = @Comanda_ ;
END IF;

END$$

DELIMiTER ;


