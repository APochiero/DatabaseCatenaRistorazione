DROP PROCEDURE IF EXISTS AggiornaStatoOggetti;
DELIMITER $$
CREATE PROCEDURE AggiornaStatoOggetti( IN Sede VARCHAR (10), OrdineDaPreparare VARCHAR(6)  )
BEGIN

DECLARE Finito INT DEFAULT 0;
DECLARE Oggetto VARCHAR (20);
DECLARE ElencoOggettiDaUsare CURSOR FOR

( SELECT DISTINCT
	OC.IDOggetto
FROM
    Ordine O
        INNER JOIN
    Piatto P ON O.IDPiatto = P.IDPiatto
        INNER JOIN
    ProcedimentoStep PR ON PR.IDPiatto = P.IDPiatto
        INNER JOIN
    Fase F ON PR.IDFase = F.IDFase
        INNER JOIN
    UtilizzoFase UF ON UF.IDFase = F.IDFase
        INNER JOIN
    OggettoCucina OC ON OC.IDOggetto = UF.IDOggetto
WHERE
    OC.IDSede = SEDE
        AND IDOrdine = OrdineDaPreparare AND OC.Stato = "Disponibile"
GROUP BY UF.IDFase );
        
DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET Finito=1;

OPEN ElencoOggettiDaUsare;

preleva : loop

FETCH ElencoOggettiDaUsare INTO Oggetto;

IF ( finito = 1 ) THEN 
	LEAVE preleva; 
END IF;

UPDATE OggettoCucina 
SET 
    Stato = 'In Uso'
WHERE
    IDOggetto = Oggetto;


END loop preleva;

CLOSE ElencoOggettiDaUsare;



END $$

DELIMITER ;
