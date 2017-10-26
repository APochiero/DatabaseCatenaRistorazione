Delimiter $$

Create Trigger ControllaAssenzaNuovoPiatto
Before Insert on NuovoPiatto for each row 

BEGIN

SET @Controlla = ( SELECT DISTINCT COUNT(*)
				   FROM Piatto 
				   WHERE Nome = New.Nome ) ;
                   
IF ( @Controlla = 1 ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Piatto già presente';
END IF;

END $$

DELIMITER ;