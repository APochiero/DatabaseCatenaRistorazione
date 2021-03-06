DROP PROCEDURE IF EXISTS ModificaTemporizzazione;
DELIMITER $$

CREATE PROCEDURE ModificaTemporizzazione (IN Numero INT,IN Tempo VARCHAR(8))
BEGIN

case

WHEN Tempo='Anni' THEN

ALTER EVENT  SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY Numero YEAR
ON COMPLETION PRESERVE;


WHEN Tempo='Mesi' THEN

ALTER EVENT SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY Numero MONTH
ON COMPLETION PRESERVE;

WHEN Tempo='Ore' THEN

ALTER EVENT  SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY Numero HOUR
ON COMPLETION PRESERVE;

WHEN Tempo='Minuti' then
ALTER EVENT SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY Numero MINUTE
ON COMPLETION PRESERVE;

WHEN Tempo='Secondi' THEN
ALTER EVENT  SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY Numero SECOND
ON COMPLETION PRESERVE;

END CASE;

END $$
DELIMITER ;
