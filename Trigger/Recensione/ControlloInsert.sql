DROP TRIGGER IF EXISTS ControllaVotoPiatto;
DELIMITER $$

Create Trigger ControllaVotoPiatto
BEFORE INSERT ON recensione FOR EACH ROW

BEGIN


SET @Ban=0;

SET @Ban= ( SELECT A.Ban
			FROM  Account A 
			WHERE NEW.AutoreRecensione=A.Nickname);
IF (@Ban=1) THEN
SIGNAL SQLSTATE '45000'
SET message_text='L Account è bannato non può recensire! ';
END IF;

IF(NEW.VotoGenerale<0 OR NEW.VotoGenerale>1) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Voto Inserito non valido Deve essere fra 0 e 1 ';

END IF;

END $$
DELIMITER ;