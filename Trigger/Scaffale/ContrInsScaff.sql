DROP TRIGGER IF EXISTS ControllaScaffale1;
DELIMITER $$
CREATE TRIGGER ControllaScaffale1
BEFORE INSERT ON Scaffale FOR EACH ROW
BEGIN
IF NEW.QuantitaMax<0 THEN 
SIGNAL SQLSTATE '45000'
SET message_text='Quantità inserita Negativa Inserire una positiva';
END IF;
END $$

DELIMITER ;