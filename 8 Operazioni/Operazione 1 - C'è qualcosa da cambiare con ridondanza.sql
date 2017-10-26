SELECT O.IdPiatto,SUM(O.Quantita)AS Quantita
FROM Ordine O INNER JOIN Comanda C USING (IdComanda)
  
WHERE O.Variazione=1 AND C.TipoTakeAway=1
GROUP BY O.IdPiatto
ORDER BY Quantita DESC
LIMIT 3