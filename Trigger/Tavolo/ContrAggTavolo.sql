DROP TRIGGER IF EXISTS AggiornaTavolo;
DELIMITER $$
CREATE TRIGGER AggiornaTavolo
BEFORE UPDATE ON Tavolo FOR EACH ROW
BEGIN

IF (New.NumeroPosti<2) THEN 

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Attenzione Il Numero Dei posti deve essere maggiore o uguale a 2 ';

END IF;
END $$
DELIMITER ;
