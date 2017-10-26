DROP PROCEDURE IF EXISTS AggiornaOrdinativi;
DELIMITER $$

CREATE PROCEDURE AggiornaOrdinativi()
BEGIN

CREATE TABLE IF NOT EXISTS MV_FornituraAutoMagazzino (
	IDIngrediente INT,
	QuantitaUsataUltimoMese INT,
	QuantitaDisponibile INT,
    QuantitaDaOrdinare INT,
	IDSede VARCHAR(10),
    FornitoriConsigliati TINYTEXT
);

TRUNCATE MV_FornituraAutoMagazzino;

INSERT INTO MV_FornituraAutoMagazzino
( SELECT 
    IDIngrediente,
    QuantitaUsataUltimoMese,
    QuantitaDisponibile,
    (QuantitaUsataUltimoMese - QuantitaDisponibile) AS QuantitaDaOrdinare,
    IngredientiUsati.IDSede,
    FornitoriConsigliati
FROM
    (  SELECT IDIngrediente, SUM(Peso_gr) AS QuantitaDisponibile, IDSede, group_concat(Distinct IDProduttore) AS FornitoriConsigliati
 FROM 
 ( SELECT 
    IDIngrediente, SedePrenotazione AS IDSede, Peso_gr , IDCOnfezione, IDProduttore
FROM
    Magazzino
        INNER JOIN
    Confezione USING (IDMagazzino)
        INNER JOIN
	lotto ON CodLotto = CodiceLotto
		INNER JOIN 
    Ingrediente ON Ingrediente = IDIngrediente
        INNER JOIN
    ProcedimentoStep PR USING (IDIngrediente)
        INNER JOIN
    Ordine USING (IDPiatto)
        INNER JOIN
    Comanda C USING (IDComanda) 
    INNER JOIN Prenotazione USING ( IDtavolo )
WHERE
    Time_stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH AND PR.IDIngrediente IS NOT NULL AND C.Tipotakeaway = 0  AND SedePrenotazione = IDSede
GROUP BY IDCOnfezione
UNION 
SELECT 
    IDIngrediente, M.IDSede, Peso_gr , IDConfezione, IDProduttore
FROM
    Magazzino M
        INNER JOIN
    Confezione USING (IDMagazzino)
        INNER JOIN
	lotto ON CodLotto = CodiceLotto
		INNER JOIN 
    Ingrediente ON Ingrediente = IDIngrediente
        INNER JOIN
    ProcedimentoStep PR USING (IDIngrediente)
        INNER JOIN
    Ordine USING (IDPiatto)
        INNER JOIN
    Comanda C USING (IDComanda) 
    INNER JOIN ComandaTakeAway CTA ON IDComanda = IDComandaTA
WHERE
    Time_stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH AND PR.IDIngrediente IS NOT NULL AND C.Tipotakeaway = 1 AND CTA.IDSede = M.IDSede
GROUP BY IDConfezione ) AS D
GROUP BY IDIngrediente , IDSede UNION SELECT 
        IDIngrediente,
            0 AS QuantitaDisponibile,
            SedePrenotazione AS IDSede, NULL
    FROM
        Prenotazione P
    INNER JOIN Tavolo USING (IDTavolo)
    INNER JOIN Comanda USING (IDTavolo)
    INNER JOIN Ordine USING (IDComanda)
    INNER JOIN ProcedimentoStep PR USING (IDPiatto)
    WHERE
        TipotakeAway = 0
            AND PR.IDIngrediente IS NOT NULL
            AND Time_Stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH
            AND IDIngrediente NOT IN (SELECT 
                Ingrediente
            FROM
                Confezione
            INNER JOIN Magazzino USING (IDMagazzino)
            WHERE
                IDSede = P.SedePrenotazione)
    GROUP BY IDIngrediente , SedePrenotazione UNION SELECT 
        IDIngrediente, 0 AS QuantitaDisponibile, IDSede, NULL
    FROM
        ComandaTakeAway CTA
    INNER JOIN Comanda ON IDComanda = IDCOmandaTA
    INNER JOIN Ordine USING (IDComanda)
    INNER JOIN ProcedimentoStep PR USING (IDPiatto)
    WHERE
        TipotakeAway = 1
            AND PR.IDIngrediente IS NOT NULL
            AND Time_Stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH
            AND IDIngrediente NOT IN (SELECT 
                Ingrediente
            FROM
                Confezione
            INNER JOIN Magazzino USING (IDMagazzino)
            WHERE
                IDSede = CTA.IDSede)
    GROUP BY IDIngrediente , IDSede) AS IngredientiDisponibili
        NATURAL JOIN
    (SELECT 
        IDIngrediente,
            SUM(SommaDose) AS QuantitaUsataUltimoMese,
            IDSede
    FROM
        (SELECT 
        IDIngrediente,
            SUM(Dose_gr) * Quantita AS SommaDose,
            SedePrenotazione AS IDSede,
            O.Quantita
    FROM
        Prenotazione
    INNER JOIN Tavolo USING (IDTavolo)
    INNER JOIN Comanda C USING (IDtavolo)
    INNER JOIN Ordine O USING (IDComanda)
    INNER JOIN ProcedimentoStep USING (IDPiatto)
    WHERE
        TipoTakeAway = 0
            AND C.Time_Stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH
            AND IDIngrediente IS NOT NULL
    GROUP BY IDIngrediente , SedePrenotazione UNION SELECT 
        IDIngrediente,
            SUM(Dose_gr) * Quantita AS SommaDose,
            IDSede,
            O.Quantita
    FROM
        ComandaTakeAway
    INNER JOIN Comanda C ON IDComanda = IDComandaTA
    INNER JOIN Ordine O USING (IDComanda)
    INNER JOIN ProcedimentoStep USING (IDPiatto)
    WHERE
        TipoTakeAway = 1
            AND C.Time_Stamp >= CURRENT_TIMESTAMP - INTERVAL 1 MONTH
            AND IDIngrediente IS NOT NULL
    GROUP BY IDIngrediente , IDSede) AS D
    GROUP BY IDIngrediente , IDSede) AS IngredientiUsati
WHERE QuantitaUsataUltimoMese - QuantitaDisponibile > 0 );

END $$

DELIMITER ;


