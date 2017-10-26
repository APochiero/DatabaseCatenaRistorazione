/* TRIGGER RICHIESTA VARIAZIONE NEL PIATTO (ESISTENZA) E NUM MAX 3 */

DROP TRIGGER IF EXISTS ControllaPresenzaVariazione1;
DELIMITER $$
CREATE TRIGGER ControllaPresenzaVariazione1
BEFORE INSERT ON ContieneVariazione FOR EACH ROW
begin

SET @idpiatto=(
				SELECT O.IDPiatto
                FROM Ordine O	
				WHERE O.IdOrdine=New.IdOrdine
			  );
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
             
SET @EsiVariaz= (   
				SELECT count(*) AS Num
				FROM ProcedimentoStep PS 
				WHERE Ps.IdPiatto=@idpiatto AND PS.IdVariazione=New.IdVariazione);
                
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

IF ((@contavar+1)>3) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT=' Hai Raggiunto il numero massimo (3) di variazioni inseribili in un ordine!';
END IF;


END $$
DELIMITER ;
