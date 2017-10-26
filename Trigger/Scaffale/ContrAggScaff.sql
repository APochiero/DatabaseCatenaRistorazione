DROP TRIGGER IF EXISTS ControllaScaffale2;
DELIMITER $$
CREATE TRIGGER ControllaScaffale2
BEFORE UPDATE ON Scaffale FOR EACH ROW
BEGIN
IF NEW.QuantitaMax <0 THEN 
SIGNAL SQLSTATE '45000'
SET message_text='Quantità Aggiornata Negativa Aggiornare con una positiva';
END IF;
END $$
DELIMITER ;
