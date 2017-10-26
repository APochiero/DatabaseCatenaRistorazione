/* QUESTO PEZZO DI CODICE QUI E' GIA STATO MESSO NELL' EVENT */
SELECT (@rowNumber:=@rowNumber+1) AS N, 
		TAB1.NuovaVariazione,
		TAB1.MEDIAVOTO,
		TAB1.TotaleValutazioni,
        TAB1.PropostoDa,
        ( SELECT COUNT(*)
		  FROM Recensione R
          WHERE R.VotoGenerale>=0.6 AND R.AutoreRecensione=TAB1.PropostoDa
		) AS RecensioniPosCliente,
		MaggPrenotSedeVar(TAB1.NUOVAVARIAZIONE) AS SediConsigliate
    
FROM  (SELECT @rowNumber:=0) AS N,
	
			(
				SELECT VNV.NuovaVariazioneValutata AS NUOVAVARIAZIONE,
                COUNT(VNV.NuovaVariazioneValutata)AS TotaleValutazioni,
                NV.AutoreNuovaVariazione AS PropostoDa,
                AVG(VNV.GradimentoNV)AS MEDIAVOTO
                
                
				FROM ValutaNuovaVariazione VNV INNER JOIN NuovaVariazione NV
                ON VNV.NuovaVariazioneValutata=NV.IdNuovaVariazione
				GROUP BY VNV.NuovaVariazioneValutata
				ORDER BY MediaVoto DESC 
			) AS TAB1
            
WHERE @rowNumber<=10
