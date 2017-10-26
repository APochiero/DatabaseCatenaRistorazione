Delimiter $$

create trigger ControllaPrenotazione2
before update on Prenotazione for each row 

begin 

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

IF  ( DAY(New.DataPrenotazione) < Day(current_date) ) then
SIGNAL SQLSTATE '45000'
SET message_text='Data precedente ad oggi';
END IF;

if ( New.DataPrenotazione = Current_date and hour(New.OraPrenotazione ) <= Hour(current_time)) then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione precendente all'ora attuale";
END IF;

if ( New.OraPrenotazione < @OraApertura ) then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione precedente all'Ora di Apertura";
END IF;

if ( New.OraPrenotazione > subtime( @OraChiusura, "3:00:00" ) ) then
SIGNAL SQLSTATE '45000'
SET message_text="Ora della Prenotazione successsiva all'Ora massima per prenotare";
END IF;


Set @TavoloAssegnato = NULL;
Set @TavoloAssegnato = ( SELECT 
    IDTavolo
FROM
    Tavolo T
        NATURAL JOIN
    Sala
WHERE
    Sala.IDSede = new.SedePrenotazione
        AND (T.NumeroPosti - New.NumeroPersone) >= 0
        AND (T.NumeroPosti - New.NumeroPersone) <= 1
        AND IDTavolo NOT IN (SELECT 
            IDTavolo
        FROM
            Prenotazione P
        WHERE
            P.DataPrenotazione = new.DataPrenotazione
                AND (P.OraPrenotazione between New.OraPrenotazione and addtime( new.OraPrenotazione, "3:00:00" ) ) )
		ORDER BY NumeroPosti
        limit 1 );
        
if ( @TavoloAssegnato is NULL ) then 
	signal sqlstate "45000"
	set message_text = "Non ci sono disponibili per la prenotazione";
else 
	set New.IDTavolo = @TavoloAssegnato;
end if;


END $$
delimiter ;
