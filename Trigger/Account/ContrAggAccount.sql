Drop Trigger IF EXISTS ControllaAccountUpdate;
DELIMITER $$
Create Trigger ControllaAccountUpdate
Before Update on Account for each row
begin

IF ( length( New.Password_ ) < 8 ) then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Password troppo corta';
END IF;

IF ( Year(New.DataNascita) < 1900 OR New.DataNascita > date_sub( current_date, interval 16 year ) ) then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Età non valida';
END IF;

IF ( New.Sesso <> 'M' AND New.Sesso <> 'F' ) then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Sesso non valido';
END IF;
 
END $$
Delimiter ;
