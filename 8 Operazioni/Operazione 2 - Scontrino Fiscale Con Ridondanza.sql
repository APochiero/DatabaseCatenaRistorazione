SELECT Prezzo
FROM comanda C INNER JOIN Prenotazione P USING (IdTavolo)
WHERE DATE(C.Time_Stamp)=P.DataPrenotazione AND
 HOUR(C.Time_Stamp) BETWEEN HOUR(P.OraPrenotazione) AND HOUR (P.OraPrenotazione+ INTERVAL 3 HOUR)
 AND P.IdTavolo = 11