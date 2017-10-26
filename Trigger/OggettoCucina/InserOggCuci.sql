DROP TRIGGER IF EXISTS ControllaOggetto;
DELIMITER $$
CREATE TRIGGER ControllaOggetto
BEFORE INSERT ON OggettoCucina FOR EACH ROW

BEGIN
IF (NEW.Tipo <> 'Macchinario' AND NEW.Tipo <> 'Attrezzatura') then

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT ='Tipo Inserito Non corretto solo Macchinario O Attrezzatura';
END IF;  

IF (NEW.stato <> 'Disponibile' AND NEW.stato <> 'In Uso' AND NEW.stato <> 'Guasto') then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT ='Tipo Stato Non corretto solo Disponibile/In Uso/Guasto';
END IF; 
                       
END $$
DELIMITER ;
