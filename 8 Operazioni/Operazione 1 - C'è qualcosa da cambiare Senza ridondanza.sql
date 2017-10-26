SELECT O.IdPiatto,SUM(O.Quantita)AS Quantita
FROM Ordine O INNER JOIN Comanda C USING (IdComanda)
  
WHERE O.IdOrdine IN ( SELECT CV.IdOrdine
       FROM ContieneVariazione CV
     )
 AND 
     C.IdComanda IN (
       SELECT CTA.IDComandaTA
       FROM ComandaTakeAway CTA
     ) 
 AND C.Time_Stamp BETWEEN Current_Date - INTERVAL 7 DAY AND Current_Date
GROUP BY O.IdPiatto
ORDER BY Quantita DESC
LIMIT 3