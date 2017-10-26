DROP PROCEDURE IF EXISTS ControllaPiattiMenu;
DELIMITER $$
CREATE PROCEDURE ControllaPiattiMenu ()
begin

DECLARE finito INT DEFAULT 0;
DECLARE sede VARCHAR(10);
DECLARE menu VARCHAR(20);
DECLARE piatto VARCHAR (10);
DECLARE ElencoPiatti CURSOR FOR 

SELECT S.IdSede,OM.IdMenu,Cm.IdPiatto
FROM Sede S INNER JOIN offertamenu OM USING (IdSede)
INNER JOIN ComponeMenu CM USING (IdMenu)
WHERE (Om.DataScadenza IS NULL OR Om.DataScadenza>Current_Date() );

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET finito=1;

CREATE TABLE IF NOT EXISTS MV_ElencoPiattiOrdinabili (
IdSede VARCHAR(10),
IdMenu VARCHAR(20),
IdPiatto VARCHAR(10),
PRIMARY KEY (IdSede,IdMenu,IdPiatto)

);

truncate TABLE MV_ElencoPiattiOrdinabili; /* ELIMINA TUTTI I RECORD */

OPEN ElencoPiatti ;
preleva : loop

fetch ElencoPiatti INTO sede,menu,piatto;
IF (finito=1) THEN
LEAVE preleva; END IF;

CALL  AggiungiMv_ElencoOrdinabili(sede,menu,piatto);

END LOOP preleva;
CLOSE ElencoPiatti;


END $$
DELIMITER ;


/*
CREATE TABLE MV_ElencoPiattiOrdinabili (
IdSede VARCHAR(6),
IdMenu VARCHAR(20),
IdPiatto VARCHAR(10),
PRIMARY KEY (IdSede,IdMenu,IdPiatto)

);
*/