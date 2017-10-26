DROP TRIGGER IF EXISTS ControllaProcedimento2;
DELIMITER $$
CREATE TRIGGER ControllaProcedimento2
BEFORE UPDATE ON ProcedimentoStep FOR EACH ROW

BEGIN
IF (NEW.Priorita<1) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L attributo priorita puo assumere solo valori numerici >1 ';
END IF;

IF (NEW.Tempo_sec<0)THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L attributo Tempo puo assumere solo valori numerici >0';
END IF;

IF (NEW.IdIngrediente IS NULL) THEN
SET NEW.Dose_gr=NULL;
SET NEW.Principale=NULL;

ELSE IF 
(NEW.IdIngrediente IS NOT NULL AND
(NEW.Dose_gr<=0 OR (NEW.Principale<>0 AND NEW.Principale<>1))) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L attributo Dose deve essere maggiore di 0';
END IF;



END IF;

END $$
DELIMITER ;
