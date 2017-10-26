DROP TRIGGER IF EXISTS ControllaPony;
DELIMITER $$

CREATE TRIGGER ControllaPony
BEFORE INSERT ON Pony FOR EACH ROW 

BEGIN
IF ( New.Stato <> "Libero" AND New.Stato <> "Occupato" ) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Stato Pony non valido';
END IF;

IF ( New.Mezzo <> 2 AND New.Mezzo <> 4 ) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Mezzo non valido';
END IF;

END $$

DELIMITER ;
