DROP TRIGGER IF EXISTS ControllaConfezione;
DELIMITER $$
CREATE TRIGGER ControllaConfezione
BEFORE INSERT ON Confezione FOR EACH ROW

BEGIN
SET NEW.Stato='Completa';
IF (NEW.Aspetto<0 OR NEW.ASPETTO>10) THEN
SIGNAL SQLSTATE '45000'
SET message_text='VALORE ASPETTO NON COMPRESO FRA 1 E 10';
END IF;

IF (NEW.Peso_gr <0  OR NEW.Prezzo_euro<0) THEN
SIGNAL SQLSTATE '45000'
SET message_text='VALORI PESO O PREZZO INFERIORI A 0';
END IF;

SET @datalotto=(SELECT L.DataProduzione
				FROM Lotto L
				WHERE L.CodiceLotto=New.CodLotto);

IF (NEW.DataAcquisto <@datalotto)then
SIGNAL SQLSTATE '45000'
SET message_text='La Data di Acquisto non può essere minore di quella di PRODUZIONE DEL LOTTO';
END IF;

IF (NEW.DataAcquisto >New.DataArrivo) THEN
SIGNAL SQLSTATE '45000'
SET message_text='La Data di Acquisto non può essere maggiore di quella di arrivo';
END IF;

IF (NEW.DataAcquisto >New.DataScadenza) THEN
SIGNAL SQLSTATE '45000'
SET message_text='La Data di Acquisto non può essere maggiore di quella di Scadenza';
END IF;

IF (NEW.DataArrivo >New.DataScadenza) THEN
SIGNAL SQLSTATE '45000'
SET message_text='La Data di Arrivo non può essere maggiore di quella di Scadenza';
END IF;

SET @maxpezziscaffale= (SELECT QuantitaMax
						FROM Scaffale S
                        WHERE S.IdScaffale=New.IdScaffale);
                        
SET@quantipezzi=( SELECT count(*) 
				  FROM	(Confezione C NATURAL JOIN  Scaffale S)
				  WHERE S.IdScaffale=New.IdScaffale );
                  
IF (@quantipezzi+1 > @maxpezziscaffale) THEN
SIGNAL SQLSTATE '45000'
SET message_text='ATTENZIONE NON C E PIU SPAZIO SU QUESTO SCAFFALE TENTARE SU UN ALTRO O CAMBIARE MAGAZZINO!';
END IF;

END $$

DELIMITER ;
