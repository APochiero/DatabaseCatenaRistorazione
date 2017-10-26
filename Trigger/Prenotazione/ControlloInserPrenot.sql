DROP TRIGGER IF EXISTS ControllaPrenotazione;
Delimiter $$
create trigger ControllaPrenotazione 
before insert on Prenotazione for each row 
begin 


SET @Ban=0;

SET @Ban= ( SELECT A.Ban
			FROM Cliente C INNER JOIN Account A ON C.CodiceFiscale=A.Proprietario
			WHERE C.CodiceFiscale=New.CodiceFiscale );

if (@Ban=1) THEN
SIGNAL SQLSTATE '45000'
SET message_text='L account non può effettuare prenotazioni!';
END IF;

if (NEW.OraPrenotazione<'00;00:00' OR NEW.OraPrenotazione>'23:59:59') THEN 
SIGNAL SQLSTATE '45000'
SET message_text='Ora Inserita Invalitda!';
END IF;

set @GiornoChiusura = ( Select GiornoChiusura 
						from sede
						where IdSede = New.SedePrenotazione );

SET @OraApertura = ( Select OraApertura
							from sede	
							where IdSede = New.SedePrenotazione );
SET @OraChiusura = ( Select OraChiusura
						from Sede
						where IdSede = New.SedePrenotazione );
	
 
if ( weekday( New.DataPrenotazione ) = @GiornoChiusura ) Then
SIGNAL SQLSTATE '45000'
SET message_text='Data coincide con il giorno di chiusura';
END IF;

IF  ( (New.DataPrenotazione) < (current_date) ) then
SIGNAL SQLSTATE '45000'
SET message_text='Data precedente ad oggi';
END IF;

if ( New.DataPrenotazione = Current_date and 
hour(New.OraPrenotazione )*60+MINUTE(New.OraPrenotazione ) <= Hour(current_time)*60+MINUTE(current_time)) then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione precendente all'ora attuale";
END IF;

if  (@OraApertura>@OraChiusura AND 
NOT( (New.OraPrenotazione BETWEEN '00:00:00' AND @OraChiusura) OR New.OraPrenotazione>@OraApertura))
then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione precedente all'Ora di Apertura %";
END IF;

if  (@OraApertura<@OraChiusura AND  New.OraPrenotazione<@OraApertura)
then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione precedente all'Ora di Apertura $";
END IF;


if  (@OraApertura<@OraChiusura AND  New.OraPrenotazione>@OraChiusura)
then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione successiva all'Ora di Chiusura";
END IF;

if (  @OraChiusura-@OraApertura>0 AND New.OraPrenotazione > subtime( @OraChiusura, "3:00:00" ) ) then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione successsiva all'Ora massima per prenotare";
END IF;


Set @TavoloAssegnato = NULL;
Set @TavoloAssegnato = ( SELECT IDTavolo
FROM Tavolo T
	NATURAL JOIN
    Sala
WHERE Sala.IDSede = new.SedePrenotazione
        AND (T.NumeroPosti - New.NumeroPersone) >= 0
        AND IDTavolo NOT IN ( 
        SELECT IDTavolo
        FROM Prenotazione P1
        WHERE P1.DataPrenotazione = new.DataPrenotazione
                AND  New.OraPrenotazione BETWEEN subtime(P1.OraPrenotazione,'03:00:00') 
                AND addtime(P1.OraPrenotazione,'03:00:00')
        
        )
		ORDER BY NumeroPosti
        limit 1 );
        
if ( @TavoloAssegnato is NULL ) then 
	signal sqlstate "45000"
	set message_text = "Non ci tavoli sono disponibili per la prenotazione";
else 
	set New.IDTavolo = @TavoloAssegnato;
end if;
END $$
delimiter ;
