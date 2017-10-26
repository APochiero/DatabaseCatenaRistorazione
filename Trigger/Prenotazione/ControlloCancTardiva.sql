DROP TRIGGER IF EXISTS ControllaPrenotazioneDelete;
Delimiter $$
Create trigger ControllaPrenotazioneDelete
before delete on Prenotazione for each row

begin 

if ( old.DataPrenotazione > current_date AND old.DataPrenotazione < current_date + INTERVAL 3 DAY ) then
SIGNAL SQLSTATE '45000'
SET message_text='Cancellazione Tardiva';
END IF;
END $$

Delimiter ;
