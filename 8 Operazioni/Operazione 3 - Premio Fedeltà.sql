SELECT 
    *
FROM
    (SELECT 
        NickName
    FROM
        (SELECT 
        NickName, COUNT(*) AS TOTRECE
    FROM
        Account A
    INNER JOIN Recensione R ON R.AutoreRecensione = A.Nickname
    WHERE
        A.Ban = 0
    GROUP BY NickName) AS TAB1
    INNER JOIN (SELECT 
        NickName, COUNT(*) AS NUMRECPOS
    FROM
        Account A
    INNER JOIN Recensione R ON R.AutoreRecensione = A.Nickname
    WHERE
        A.Ban = 0 AND R.VotoGenerale >= 0.6
    GROUP BY Nickname) AS TAB2 USING (NickName)
    WHERE
        TAB1.TOTRECE = TAB2.NUMRECPOS) AS TAB3
WHERE
    (SELECT 
            COUNT(DISTINCT APP1.Sede) AS SedeDiverse
        FROM
            (SELECT 
                A1.Nickname, P.SedePrenotazione AS SEDE
            FROM
                Account A1
            INNER JOIN Cliente C1 ON A1.Proprietario = C1.CodiceFiscale
            INNER JOIN Prenotazione P USING (CodiceFiscale) UNION ALL SELECT 
                A1.Nickname, CTA.IdSede AS Sede
            FROM
                Account A1
            INNER JOIN comandatakeaway CTA ON A1.NickName = CTA.AccountComanda) AS APP1
        WHERE
            APP1.NickName = TAB3.NickName) >= 2
