DROP PROCEDURE IF EXISTS CercaConfezioniBuoneDaUsare;

DELIMITER $$

CREATE PROCEDURE CercaConfezioniBuoneDaUsare ( IN IDSede_ VARCHAR(10), IN DoseUsata_ INT, IN Ordine_ VARCHAR(6), IN Ingrediente_ INT ) 
BEGIN
DECLARE Confezione_ VARCHAR(20);
DECLARE PesoTotale_ INT;
DECLARE PesoAttuale_ INT;
DECLARE SommaPeso INT DEFAULT 0;
DECLARE Stato_ VARCHAR(10);
DECLARE ElencoConfezioni CURSOR FOR

SELECT IDConfezione, ( @SommaPeso := @SommaPeso + Peso_gr ) AS PesoTotale, Peso_gr, Stato
FROM ( 
	SELECT 
		C.IDConfezione, Peso_gr, Stato
	FROM
		Confezione C
			INNER JOIN Scaffale Sc USING (IdScaffale) 
            INNER JOIN
		Magazzino USING (IdMagazzino)
			INNER JOIN
		Sede USING (IDSede)
	WHERE
		IDSede = IDSede_ AND (STATO = 'Parziale' OR Stato = "Completa" ) AND Aspetto > 5
			AND C.Ingrediente IN (SELECT 
                I.IdIngrediente
            FROM
                INgrediente I
            WHERE
                I.IDIngrediente = Ingrediente_ )
    ORDER BY Stato DESC , DataScadenza , Aspetto) AS D;

SET @SommaPeso = 0;
DROP TEMPORARY TABLE IF EXISTS Temp_ConfezioneInUso;
CREATE TEMPORARY TABLE IF NOT EXISTS Temp_ConfezioneInUso ( 
IDConfezione VARCHAR(20),
IDOrdine VARCHAR(6),
QuantitaAttuale INT,
StatoAttuale VARCHAR(10),
PRIMARY KEY ( IDConfezione, IDOrdine ) );
Open ElencoConfezioni;

preleva : loop

FETCH ElencoConfezioni INTO Confezione_, PesoTotale_, PesoAttuale_, Stato_;

INSERT INTO temp_ConfezioneInUso
VALUE ( Confezione_, Ordine_, PesoAttuale_, Stato_);

UPDATE Confezione
SET Stato = "In Uso"
WHERE IDConfezione = Confezione_;

IF ( PesoTotale_ >= DoseUsata_ ) THEN
LEAVE preleva;
END IF;

end loop preleva;

close ElencoConfezioni;


END $$
DELIMITER ;