Delimiter $$

Create trigger ControllaPrenotazioneDelete
before delete on Prenotazione for each row

begin 

if ( old.DataPrenotazione > current_date AND old.DataPrenotazione < current_date + 3 ) then
SIGNAL SQLSTATE '45000'
SET message_text='Cancellazione Tardiva';
END IF;

END $$

Delimiter ;