DELIMITER $$

CREATE TRIGGER AggiornaStatoComanda 
AFTER UPDATE ON Ordine FOR EACH ROW

BEGIN

SET @PiattiComanda = ( SELECT 
							COUNT(*)
					   FROM
							Ordine
					   WHERE
							IDComanda = NEW.IDComanda );

SET @PiattiInPreparazione = ( SELECT 
									COUNT(*)
							  FROM
									Ordine
							  WHERE
									IDComanda = NEW.IDComanda
							    AND Stato = 'InPreparazione' );
                                
SET @PiattiServizio = ( SELECT 
							COUNT(*)
						FROM
							Ordine
						WHERE
							IDComanda = NEW.IDComanda
						AND Stato = 'Servizio' );
                        
IF ( @PiattiInPreparazione > 0 AND @PiattiServizio = 0  ) THEN
	UPDATE Comanda C
    SET Stato = 'InPreparazione'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;    

IF ( @PiattiServizio > 0 AND @PiattiComanda > @PiattiServizio  ) THEN
	UPDATE Comanda C
	SET Stato = 'Parziale'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;

IF ( @PiattiServizio = @PiattiComanda ) THEN
	UPDATE Comanda C
	SET Stato = 'Evasa'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;

END $$

DELIMITER ;
    

    

