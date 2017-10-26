DROP PROCEDURE IF EXISTS ModificaBan;
DELIMITER $$
CREATE PROCEDURE ModificaBan ()
begin

DECLARE Finito INT DEFAULT 0;
DECLARE CodiceFiscale VARCHAR(255);

DECLARE ElencoDaBan CURSOR FOR 

SELECT P1.CodiceFiscale
FROM
    Prenotazione P1
	
WHERE
    (P1.DataPrenotazione = CURRENT_DATE - INTERVAL 1 DAY)
       AND 
        NOT EXISTS (
					  SELECT *
					  FROM Prenotazione P INNER JOIN Comanda C USING (IdTavolo)
					  WHERE P.DataPrenotazione=P1.DataPrenotazione AND P.OraPrenotazione=P1.OraPrenotazione
					  AND 
       HOUR(C.Time_Stamp) * 60 + MINUTE(C.Time_Stamp) 
        BETWEEN HOUR(P1.OraPrenotazione) * 60 + MINUTE(P1.OraPrenotazione) 
        AND 
        HOUR(P1.OraPrenotazione) * 60 + MINUTE(P1.OraPrenotazione)+180
        );

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET Finito=1;

Open ElencoDaBan;

preleva : loop

fetch ElencoDaBan into CodiceFiscale;

IF (finito=1) THEN 
LEAVE preleva; 
END IF;

UPDATE Account
SET Ban=1
WHERE Proprietario=CodiceFiscale;


end loop preleva;

close ElencoDaBan;

END $$
DELIMITER ;