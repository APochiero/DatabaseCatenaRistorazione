DROP TRIGGER IF EXISTS AggiornaComandaSemplice;
DELIMITER $$
CREATE TRIGGER AggiornaComandaSemplice
BEFORE UPDATE ON Comanda FOR EACH ROW
begin


if (New.Stato<>'Nuova' AND New.Stato<>'InPreparazione' AND New.Stato<>'Parziale' AND
New.Stato<>'Evasa') THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Lo stato Inserito Non è valido';

END IF;

if (New.TipoTakeAway<>Old.TipoTakeAway) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Non Puoi Cambiare il tipo di comanda in questa tabella!';
END IF;

if (New.TipoTakeAway=0 AND New.IdTavolo IS  NULL) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La Comanda Inserita è presa in Ristorante, occorre che IL TAVOLO NON SIA NULL';
END IF;

if (New.TipoTakeAway=1 AND New.IdTavolo IS  NOT NULL) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La Comanda Inserita è presa da un Account, occorre che IL TAVOLO SIA NULL';
END IF;

IF (NEW.Prezzo<0) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='ERRORE IL PREZZO NON PUO ESSERE NEGATIVO';
END IF;

END $$

DELIMITER ;
