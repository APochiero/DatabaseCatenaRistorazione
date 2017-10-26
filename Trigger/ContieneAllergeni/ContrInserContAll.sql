DROP TRIGGER IF EXISTS PositivoAllerg1;
DELIMITER $$
CREATE TRIGGER PositivoAllerg1
BEFORE INSERT ON ContieneAllergeni
FOR EACH ROW
BEGIN
IF NEW.Quantita_gr<0 THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Inserisci una quantità positiva';
END IF;
END $$