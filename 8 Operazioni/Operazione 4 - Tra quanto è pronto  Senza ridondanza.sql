SELECT 
    SUM(TempoOrdine)
FROM
    Ordine
        INNER JOIN
    (SELECT 
        SUM(tempo) AS TempoOrdine, D.IDOrdine
    FROM
        (SELECT 
        NuovoTempo AS TEMPO, CV.IDOrdine
    FROM
        Ordine
    INNER JOIN ProcedimentoStep PR USING (IDPiatto)
    INNER JOIN ContieneVariazione CV USING (IDVariazione)
    INNER JOIN Variazione USING (IDVariazione)
    WHERE
        PR.IDvariazione = CV.IDVariazione UNION SELECT 
        Tempo_sec AS TEMPO, O.IDOrdine
    FROM
        Ordine O
    INNER JOIN ProcedimentoStep PR USING (IDPiatto)
    LEFT OUTER JOIN contienevariazione CV USING (IDVariazione)
    WHERE
        PR.IDVariazione NOT IN (SELECT 
                IDVariazione
            FROM
                contienevariazione CV1
            WHERE
                CV1.IDOrdine = O.IDOrdine)
            OR PR.IDVariazione IS NULL) AS D
    GROUP BY IDOrdine) AS TAB1 USING (IDOrdine)
WHERE
    IDComanda = 000007