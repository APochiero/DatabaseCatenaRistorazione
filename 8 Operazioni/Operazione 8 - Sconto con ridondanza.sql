UPDATE ComponeMenu
SET Prezzo=Prezzo-0.1*Prezzo
WHERE IdMenu IN (
 
SELECT OM.IdMenu
FROM OffertaMenu OM INNER JOIN 
 (
  SELECT TAB1.IdSede,SUM(TAB1.Quantita) AS QUANT
  FROM (
    SELECT P.SedePrenotazione AS IdSede,O.IdOrdine,O.Quantita
    FROM Prenotazione P INNER JOIN Comanda C USING(IdTavolo)
    INNER JOIN Ordine O USING (IdComanda)
    
    WHERE P.DataPrenotazione BETWEEN current_date - INTERVAL 1 MONTH AND current_date AND
    DATE(C.Time_Stamp)=P.DataPrenotazione
    AND
    HOUR(C.Time_Stamp) BETWEEN HOUR(P.OraPrenotazione) AND HOUR (P.OraPrenotazione+ INTERVAL 3 HOUR) AND
    O.Variazione=0

  UNION

    SELECT CTA.IdSede,O.IdOrdine,O.Quantita
    FROM comandatakeaway CTA INNER JOIN Comanda C ON CTA.IdComandaTA=C.IdComanda
    INNER JOIN Ordine O USING (IdComanda)
    WHERE DATE(C.Time_Stamp) BETWEEN current_date()-INTERVAL 1 MONTH AND current_date AND  
 O.Variazione=1
    )AS TAB1

  GROUP BY Tab1.IdSede
  HAVING QUANT>5
    
  ) AS TAB2
     USING (IdSede)

WHERE (OM.DataScadenza IS NULL 
    OR current_date between OM.DataIntroduzione AND OM.DataScadenza ) )
