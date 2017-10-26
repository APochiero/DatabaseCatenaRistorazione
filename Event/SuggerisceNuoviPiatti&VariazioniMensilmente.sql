DROP EVENT IF EXISTS SuggerisciNuoviPiattieVariazioni;
CREATE EVENT  SuggerisciNuoviPiattieVariazioni
ON SCHEDULE EVERY 1 MONTH
ON COMPLETION PRESERVE
		DO
        
CREATE TABLE IF NOT EXISTS MV_NuoviPiattiSuggeriti (
		RANK INT,
		NuovoPiatto VARCHAR(6),
		MediaVoto DOUBLE,
		TotaleValutazioni INT,
		PropostoDa VARCHAR(30),
		RecensioniPosCliente INT,
		SediConsigliate TEXT,
		PRIMARY KEY(RANK)

		);
		TRUNCATE TABLE MV_NuoviPiattiSuggeriti;


CREATE TABLE IF NOT EXISTS MV_NuoveVariazioniSuggerite (
		RANK INT,
		NuovaVariazione VARCHAR(6),
		MediaVoto DOUBLE,
		TotaleValutazioni INT,
		PropostoDa VARCHAR(30),
		RecensioniPosCliente INT,
		SediConsigliate TEXT,
		PRIMARY KEY(RANK)

		);
		TRUNCATE TABLE MV_NuoveVariazioniSuggerite;



		INSERT INTO MV_NuoviPiattiSuggeriti (

		SELECT (@rowNumber:=@rowNumber+1) AS RANK, 
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

		);

		INSERT INTO  MV_NuoveVariazioniSuggerite (
		SELECT (@rowNumber:=@rowNumber+1) AS RANK, 
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
		);
        

END$$





DELIMITER ;