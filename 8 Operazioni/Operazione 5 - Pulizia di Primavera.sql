DELETE P1.*
 FROM Prenotazione P1
 LEFT OUTER JOIN
 (
 SELECT *
 FROM  prenotazione P 
 LEFT OUTER JOIN Comanda Co USING(IdTavolo)
 ) AS TAB1 
    USING (DataPrenotazione,OraPrenotazione,IdTavolo)
WHERE TAB1.IdComanda IS NULL