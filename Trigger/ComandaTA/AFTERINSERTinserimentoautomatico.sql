DROP TRIGGER IF EXISTS InserisciComandaTA;
DELIMITER $$
CREATE TRIGGER InserisciComandaTA 
AFTER INSERT ON ComandaTakeAway FOR EACH ROW

BEGIN

INSERT INTO Comanda 
VALUES ( NEW.IDComandaTA, current_timestamp, "Nuova", 1, 0, NULL );

END $$

DELIMITER ;
