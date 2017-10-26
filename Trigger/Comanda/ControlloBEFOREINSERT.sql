DROP TRIGGER IF EXISTS InserimentoComandaSemplice;
DELIMITER $$
CREATE TRIGGER InserimentoComandaSemplice
BEFORE INSERT ON Comanda FOR EACH ROW
begin
set NEW.Time_stamp=CURRENT_TIMESTAMP();
set NEW.Stato='Nuova';

set NEW.Prezzo=0;

if (New.TipoTakeAway<>0 AND New.TipoTakeAway<>1) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Il Tipo può essere solo 0 o 1';

END IF;

if (New.TipoTakeAway=1 AND New.IdTavolo IS NOT NULL) THEN
SET New.IdTavolo=NULL;
END IF;

if (New.TipoTakeAway=0 AND New.IdTavolo IS  NULL) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La Comanda Inserita è presa in Ristorante, occorre che IL TAVOLO NON SIA NULL';
END IF;

END $$
DELIMITER ;
