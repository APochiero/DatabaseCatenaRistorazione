SELECT TAB1.IdComanda, SUM(TAB1.Prezzo) AS PREZZOTOTALE
FROM (
SELECT DISTINCT IDPiatto,C.IDCOmanda,CM.Prezzo
 FROM  Prenotazione P inner join comanda C USING (IdTavolo)
 INNER JOIN ORDINE USING (IdComanda)
 INNER JOIN ComponeMenu CM Using (IdPiatto)
 INNER JOIN OffertaMenu OM USING (IdMenu)
 WHERE DATE(C.Time_Stamp)=P.DataPrenotazione AND
 HOUR(C.Time_Stamp) BETWEEN HOUR(P.OraPrenotazione) AND HOUR (P.OraPrenotazione+ INTERVAL 3 HOUR)
 AND C.IdTavolo=11 AND P.SedePrenotazione=OM.IdSede
    ) AS TAB1