DROP FUNCTION IF EXISTS MaggPrenotSedeVar;
DELIMITER $$

CREATE FUNCTION MaggPrenotSedeVar (NVariazioneVal VARCHAR(6))
RETURNS varchar(255) NOT deterministic

BEGIN 
DECLARE LISTASEDI VARCHAR(255) DEFAULT NULL;

SET LISTASEDI=(	
			
            SELECT GROUP_CONCAT(TAB2.SedeConsigliata)
            FROM ( 
				select P.SedePrenotazione AS SedeConsigliata, COUNT(*) AS NUMVAL
				FROM valutanuovaVariazione VNV1 INNER JOIN Account A on VNV1.AutoreValutazioneNV=A.Nickname
				INNER JOIN CLIENTE C ON A.Proprietario=C.CodiceFiscale
				INNER JOIN prenotazione P ON A.Proprietario=P.CodiceFiscale
          
				WHERE NVariazioneVAl=VNV1.NuovaVariazioneValutata AND
				A.Nickname= VNV1.AutoreValutazioneNV
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