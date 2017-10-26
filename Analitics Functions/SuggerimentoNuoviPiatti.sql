
/* QUESTO PEZZO DI CODICE E' GIA STATO MESSO NELL EVENT */
SELECT (@rowNumber:=@rowNumber+1) AS N, 
		TAB1.NUOVOPIATTO,
		TAB1.MEDIAVOTO,
		TAB1.TotaleValutazioni,
        TAB1.PropostoDa,
        ( SELECT COUNT(*)
		  FROM Recensione R
          WHERE R.VotoGenerale>=0.6 AND R.AutoreRecensione=TAB1.PropostoDa
		) AS RecensioniPosCliente,
		MaggPrenotSede(TAB1.NUOVOPIATTO) AS SediConsigliate
    
FROM  (SELECT @rowNumber:=0) AS N,
	
			(
				SELECT VNP.NuovoPiattoValutato AS NUOVOPIATTO,
                COUNT(VNP.NuovoPiattoValutato)AS TotaleValutazioni,
                NP.AutoreNuovoPiatto AS PropostoDa,
                AVG(VNP.GradimentoNP)AS MEDIAVOTO
				FROM ValutaNuovoPiatto VNP INNER JOIN NuovoPiatto NP ON VNP.NuovoPiattoValutato=NP.IdNuovoPiatto
				GROUP BY VNP.NuovoPiattoValutato
				ORDER BY MediaVoto DESC 
			) AS TAB1
            
WHERE @rowNumber<=10

