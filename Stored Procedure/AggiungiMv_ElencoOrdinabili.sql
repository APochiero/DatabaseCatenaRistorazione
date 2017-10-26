DROP PROCEDURE IF EXISTS AggiungiMv_ElencoOrdinabili;
DELIMITER $$
CREATE PROCEDURE AggiungiMv_ElencoOrdinabili(IN VAR_SEDE VARCHAR(10), IN VAR_MENU VARCHAR(20), IN VAR_PIATTO VARCHAR(10))
BEGIN
DECLARE NumIngrTot1 INT DEFAULT 0;
DECLARE NumDisponibilita1 INT DEFAULT 0;
DECLARE NumIngrTot2 INT DEFAULT 0;
DECLARE NumDisponibilita2 INT DEFAULT 0;


/* VERIFICA LA PRESENZA DI INGREDIENTI PRINCIPALI SUFFICIENTI IN MAGAZZINO */

SET NumIngrTot1=(SELECT COUNT(distinct PS.IdIngrediente,Ps.Principale)AS NumeroIngredienti 
				 FROM (ComponeMenu CM NATURAL JOIN Piatto P) 
                 INNER JOIN procedimentostep PS USING (IdPiatto)
    WHERE (Cm.IdMenu=VAR_MENU AND Cm.IdPiatto=VAR_Piatto AND PS.Principale=1));
     /* CONTA DEL NUMERO DI INGREDIENTI PRINCIPALI  IN UN PIATTO SPECIFICO DEL MENU */

SET NumDisponibilita1=(
SELECT COUNT(*)
FROM  (SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(PS.Dose_gr) AS DoseTot
	   FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
	   INNER JOIN Ingrediente I USING (IdIngrediente)
	   WHERE    CM.IdMenu =  VAR_MENU AND CM.IdPiatto=VAR_PIATTO /*QUI VALORE */
       GROUP BY PS.IdIngrediente,PS.Principale
       HAVING Ps.Principale=1 ) 
       AS INec /* Tutti gli ingredienti principali Necessari per la ricetta IN UN PIATTO */
       INNER JOIN
       
       ( SELECT I.IdIngrediente,I.Nome,SUM(Conf.Peso_gr) AS Qdisp
		 FROM (Sede S
		 INNER JOIN Magazzino M USING (IdSede)
		 INNER JOIN Scaffale Sc USING (IdMagazzino)
         INNER JOIN (
					  SELECT C.IdScaffale,C.Ingrediente,C.Peso_gr 
					  FROM Confezione C
					  WHERE (C.DataArrivo+INTERVAL 3 DAY < current_date() AND C.Aspetto>=6 
                      AND C.DataScadenza >Current_Date() ) ) AS Conf
         USING (IdScaffale)
		 INNER JOIN Ingrediente I ON Conf.Ingrediente = I.IdIngrediente) 
		 WHERE (S.IdSede = VAR_SEDE )
         /*  O SE NON ANCORA ARRIVATO AL PIU 3 GIORNI QUI VALORE @sede e datascadenza almeno maggiore di 1 mese +1 */
         GROUP BY I.IdIngrediente
		) AS IDISP  USING (IdIngrediente)
 /* Tutti gli ingredienti disponibili in magazzino che occorrono per la ricetta  */
WHERE (INec.DoseTot*2<IDisp.Qdisp)

);


/* VARIFICA LA PRESENZA DI INGREDIENTI NON PRINCIPALI E INGREDIENTI PER VARIAZIONI */



SET	NumIngrTot2= (	SELECT COUNT(*)
					FROM(
							SELECT  distinct PS.IdIngrediente 
							FROM (ComponeMenu CM NATURAL JOIN Piatto P) 
                            INNER JOIN procedimentostep PS USING (IdPiatto)
							WHERE CM.IdPiatto=VAR_PIATTO AND Cm.IdMenu=VAR_MENU 
                            AND PS.IdIngrediente IS NOT NULL

					    UNION
							Select Distinct V.Ingrediente
							FROM (ComponeMenu CM NATURAL JOIN Piatto P) 
                            INNER JOIN procedimentostep PS USING (IdPiatto)
							INNER JOIN Variazione V USING (IdVariazione)
							INNER JOIN Ingrediente I ON I.IdIngrediente=V.Ingrediente
							WHERE CM.IdPiatto=VAR_PIATTO AND Cm.IdMenu=VAR_MENU 
							AND V.Ingrediente IS NOT NULL
						)   AS TAB1  
                        );
    

SET NumDisponibilita2= (
SELECT COUNT(*)
FROM  
(
		SELECT AAA.IdMenu,AAA.IdIngrediente, AAA.Nome, SUM(AAA.DoseTot) AS DoseTot
		FROM (
	
				(
				SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(PS.Dose_gr) AS DoseTot
				FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
				INNER JOIN Ingrediente I USING (IdIngrediente)
				WHERE    CM.IdMenu = VAR_MENU AND CM.IdPiatto=VAR_PIATTO /*QUI VALORE */
				GROUP BY PS.IdIngrediente 
				)
       
				UNION 
				(
				SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(V.NuovaDose) AS DoseTot
				FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
				INNER JOIN Variazione V USING (IdVariazione)
				INNER JOIN Ingrediente I ON I.IdIngrediente=V.Ingrediente
				WHERE    CM.IdMenu = VAR_MENU AND CM.IdPiatto=VAR_PIATTO/*QUI VALORE */
				GROUP BY PS.IdIngrediente 
				)
			) AS AAA
		GROUP BY AAA.IdIngrediente 

)  AS INec

 INNER JOIN
       
       ( SELECT I.IdIngrediente,I.Nome,SUM(Conf.Peso_gr) AS Qdisp
		 FROM (Sede S
		 INNER JOIN Magazzino M USING (IdSede)
		 INNER JOIN Scaffale Sc USING (IdMagazzino)
         INNER JOIN (
					  SELECT C.IdScaffale,C.Ingrediente,C.Peso_gr 
					  FROM Confezione C
					  WHERE (C.DataArrivo+INTERVAL 3 DAY < current_date()
                      AND C.DataScadenza >Current_Date() ) ) AS Conf
         USING (IdScaffale)
		 INNER JOIN Ingrediente I ON Conf.Ingrediente = I.IdIngrediente) 
		 WHERE (S.IdSede = VAR_SEDE )
         /*  O SE NON ANCORA ARRIVATO AL PIU 3 GIORNI QUI VALORE @sede e datascadenza almeno maggiore di 1 mese +1 */
         GROUP BY I.IdIngrediente
		) AS IDISP  
        
USING (IdIngrediente)

WHERE (INec.DoseTot*2<IDisp.Qdisp));




IF (NumIngrTot1=NumDisponibilita1 AND NumIngrTot2=NumDisponibilita2) then

INSERT INTO MV_ElencoPiattiOrdinabili VALUES (VAR_Sede,VAR_Menu,VAR_Piatto);

END IF;




END $$
DELIMITER ;