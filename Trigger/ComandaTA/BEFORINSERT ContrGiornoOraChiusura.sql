DROP TRIGGER IF EXISTS InsertTakeAway;
DELIMITER $$

CREATE TRIGGER InsertTakeAway
BEFORE INSERT ON ComandaTakeAway FOR EACH row
begin

SET @Ban= (SELECT Ban
		   FROM Account
		   WHERE New.AccountComanda= Nickname);
           
IF (@Ban=1)THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L account inserito non puo fare ordini, il suo sito è bloccato!' ;

END IF;


set @GiornoChiusura = ( Select GiornoChiusura 
						from sede
						where IdSede = New.IdSede );

SET @OraApertura = ( Select OraApertura
					 from sede	
					 where IdSede = New.IdSede );
SET @OraChiusura = ( Select OraChiusura
						from Sede
						where IdSede = New.IdSede );
	
 
if ( weekday( current_date() ) = @GiornoChiusura ) Then
SIGNAL SQLSTATE '45000'
SET message_text='Data coincide con il giorno di chiusura';
END IF;


if  (@OraApertura>@OraChiusura AND 
NOT( (current_time() BETWEEN '00:00:00' AND @OraChiusura) OR current_time()>@OraApertura))
then
SIGNAL SQLSTATE '45000'
SET message_text="A quest ora la sede è chiusa! %";
END IF;

if  (@OraApertura<@OraChiusura AND  current_time()<@OraApertura)
then
SIGNAL SQLSTATE '45000'
SET message_text="A quest ora la sede deve ancora aprire $";
END IF;


if  (@OraApertura<@OraChiusura AND  current_time()>@OraChiusura)
then
SIGNAL SQLSTATE '45000'
SET message_text="A quest ora la sede è gia chiusa";
END IF;








END $$

DELIMITER ;