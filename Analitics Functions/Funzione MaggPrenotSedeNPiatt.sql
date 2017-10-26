DROP FUNCTION IF EXISTS MaggPrenotSede;
DELIMITER $$

CREATE FUNCTION MaggPrenotSede (NPiattoVal VARCHAR(6))
RETURNS varchar(255) NOT deterministic

BEGIN 
DECLARE LISTASEDI VARCHAR(255) DEFAULT NULL;

SET LISTASEDI=(	
			
            SELECT GROUP_CONCAT(TAB2.SedeConsigliata)
            FROM ( 
				select P.SedePrenotazione AS SedeConsigliata, COUNT(*) AS NUMVAL
				FROM valutanuovopiatto VNP1 INNER JOIN Account A on VNP1.AutoreValutazioneNP=A.Nickname
				INNER JOIN CLIENTE C ON A.Proprietario=C.CodiceFiscale
				INNER JOIN prenotazione P ON A.Proprietario=P.CodiceFiscale
          
				WHERE NPiattoVal=VNP1.NuovoPiattoValutato AND
				A.Nickname= VNP1.AutoreValutazioneNP
                GROUP BY P.SedePrenotazione
                ORDER BY NUMVAL DESC
                LIMIT 2 /* PRENDE LE PRIME 2 Sedi DOVE I VALUTANTI SONO STATI PIU SPESSO A MANGIARE */
                ) AS TAB2
           );
IF (LISTASEDI IS NULL) THEN
SET LISTASEDI='Nessuna In Particolare';
END IF;        

RETURN LISTASEDI;

END $$
DELIMITER ;