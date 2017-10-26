DROP TRIGGER IF EXISTS ControllaSede1;
DELIMITER $$
CREATE TRIGGER ControllaSede1
BEFORE UPDATE ON Sede  FOR EACH row
BEGIN

IF (New.Civico<1) then
SIGNAL SQLSTATE '45000'
SET message_text='Il civico deve essere maggiore di 1 ! ';

END IF;

IF (New.OraApertura <'00:00:00 ' OR New.OraApertura>'23:59:59')then
SIGNAL SQLSTATE '45000'
SET message_text='L Orario Apertura deve essere obbligatoriamente dalle 00:00:00 alle 23:59:59 ';
END IF;

IF (New.OraChiusura<'00:00:00 ' OR New.OraChiusura>'23:59:59')then
SIGNAL SQLSTATE '45000'
SET message_text='L Orario Chiusura deve essere obbligatoriamente dalle 00:00:00 alle 23:59:59 ';
END IF;

IF (New.OraChiusura= New.OraApertura) then
SIGNAL SQLSTATE '45000'
SET message_text='L Orario Chiusura deve essere diverso da quello di apertura! ';
END IF;

IF (New.GiornoChiusura<1 OR New.GiornoChiusura>7)  then
SIGNAL SQLSTATE '45000'
SET message_text='Il giorno chiusura è un intero da 1 a 7! ';
END IF;
END $$
DELIMITER ;
