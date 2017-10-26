UPDATE ComponeMenu 
SET 
    Prezzo = Prezzo - 0.1 * Prezzo
WHERE
    IdMenu IN (SELECT 
            OM.IdMenu
        FROM
            OffertaMenu OM
                INNER JOIN
            (SELECT 
                TAB1.IdSede, SUM(TAB1.Quantita) AS QUANT
            FROM
                (SELECT 
                P.SedePrenotazione AS IdSede, O.IdOrdine, O.Quantita
            FROM
                Prenotazione P
            INNER JOIN Comanda C USING (IdTavolo)
            INNER JOIN Ordine O USING (IdComanda)
            LEFT OUTER JOIN contienevariazione CV USING (IdOrdine)
            WHERE
                P.DataPrenotazione BETWEEN CURRENT_DATE - INTERVAL 1 MONTH AND CURRENT_DATE
                    AND DATE(C.Time_Stamp) = P.DataPrenotazione
                    AND HOUR(C.Time_Stamp) BETWEEN HOUR(P.OraPrenotazione) 
                    AND HOUR(P.OraPrenotazione + INTERVAL 3 HOUR)
                    AND CV.IdVariazione IS NULL UNION SELECT 
                CTA.IdSede, O.IdOrdine, O.Quantita
            FROM
                comandatakeaway CTA
            INNER JOIN Comanda C ON CTA.IdComandaTA = C.IdComanda
            INNER JOIN Ordine O USING (IdComanda)
            LEFT OUTER JOIN ContieneVariazione CV USING (IdOrdine)
            WHERE
                DATE(C.Time_Stamp) BETWEEN CURRENT_DATE() - INTERVAL 1 MONTH AND CURRENT_DATE()
                    AND CV.IdVariazione IS NULL) AS TAB1
            GROUP BY Tab1.IdSede
            HAVING QUANT > 5) AS TAB2 USING (IdSede)
        WHERE
            (OM.DataScadenza IS NULL
                OR CURRENT_DATE() BETWEEN OM.DataIntroduzione AND OM.DataScadenza))
