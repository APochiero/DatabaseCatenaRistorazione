DROP TRIGGER IF EXISTS ControllaVotoPiatto1;
DELIMITER $$

Create Trigger ControllaVotoPiatto1
BEFORE UPDATE ON PiattoRecensito FOR EACH ROW

BEGIN

IF(NEW.Voto<0 OR NEW.voto>10) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Voto Inserito non valido Deve essere fra 0 e 10 ';

END IF;

END $$
DELIMITER ;