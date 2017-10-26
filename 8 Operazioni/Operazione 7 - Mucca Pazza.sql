DELETE C1.*
FROM Confezione C1 INNER JOIN (SELECT 
      IDConfezione
    FROM 
        Ingrediente I
            INNER JOIN
       Luogo L ON L.CAP = I.LuogoProduzione
			INNER JOIN 
	   Confezione C ON C.Ingrediente = I.IDIngrediente
    WHERE
        I.Nome = 'Carne Di Manzo'
        AND L.Nazione = ‘Francia’) AS D ON C1.IDConfezione = D.IDCOnfezione


