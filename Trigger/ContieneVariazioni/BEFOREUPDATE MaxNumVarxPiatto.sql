DROP TRIGGER IF EXISTS ControllaPresenzaVariazione2;
DELIMITER $$
CREATE TRIGGER ControllaPresenzaVariazione2
BEFORE UPDATE ON ContieneVariazione FOR EACH ROW
begin

SET @idpiatto=(
				SELECT O.IDPiatto
                FROM Ordine O	
				WHERE O.IdOrdine=New.IdOrdine
			  );
SET @EsiVariaz= (   
				SELECT count(*) AS Num
				FROM ProcedimentoStep PS 
				WHERE Ps.IdPiatto=@idpiatto AND PS.IdVariazione=New.IdVariazione);
                
SET @poss=    (
				SELECT O.Variazione
                FROM Ordine O	
				WHERE O.IdOrdine=New.IdOrdine
			  );
IF (@poss=0) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L ordine inserito non può contenere variazioni cambia il valore "variazione"
dentro ordine ';

END IF;                
                
                
IF (@EsiVariaz=0) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Attenzione La variazione Richiesta Non è tra quelle selezionabili, relative al 
piatto in ordine ';

END IF;

SET @contavar= ( 
				SELECT COUNT(*)
                FROM contienevariazione CV INNER JOIN Ordine O USING (IdOrdine)
                WHERE CV.IdOrdine=New.IdOrdine 

);

IF (OLD.IdOrdine<>NEW.IdOrdine AND (@contavar+1)>3 ) THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT=' Hai Raggiunto il numero massimo (3) di variazioni inseribili in un ordine!';
END IF;

END $$
DELIMITER ;

