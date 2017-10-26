DELIMITER $$

CREATE TRIGGER InserisciComandaTA 
AFTER INSERT ON ComandaTakeAway FOR EACH ROW

BEGIN

INSERT INTO Comanda 
VALUES ( NEW.IDComandaTA, current_time, "Nuova", 1, NULL, NULL );

END $$

DELIMITER ;
