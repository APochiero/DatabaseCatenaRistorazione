DROP TRIGGER IF EXISTS ControllaVariazione2;
DELIMITER $$
CREATE TRIGGER ControllaVariazione2
BEFORE UPDATE ON Variazione FOR EACH row
BEGIN

if (NEW.NuovaDose IS NOT NULL  AND  (NEW.NuovaDose<=0 OR NEW.Ingrediente IS NULL)) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Nuova dose non può essere negativa oppure l ingrediente inserito non può essere null';
END IF;


IF (NEW.Tipologia <>'A' AND NEW.Tipologia <>'S' AND NEW.Tipologia <>'E') THEN
SIGNAL SQLSTATE '45000'
SET message_text='Tipologia può essere solo aggiungi A sostituisci  S o elimina E';
END IF;



if (NEW.Tipologia='E') THEN
SET NEW.Ingrediente=NULL;
SET NEW.NuovaDose=NULL;
SET NEW.Fase=NULL;
SET NEW.NuovoTempo=0;
END IF;

if (NEW.NuovoTempo<0) THEN
SIGNAL SQLSTATE '45000'
SET message_text='NuovaTempo non può essere negativo';
END IF;

IF (NEW.Tipologia='A' AND New.Ingrediente IS  NULL AND NEW.Fase IS  NULL) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Attenzione L inserimento prevede almeno un ingrediete o una fase!';
END IF;

IF (NEW.Tipologia='S' AND New.Ingrediente IS NULL AND NEW.Fase IS  NULL) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Attenzione La sostituzione prevede almeno un ingrediete o una fase!';
END IF;


END $$
DELIMITER ;
