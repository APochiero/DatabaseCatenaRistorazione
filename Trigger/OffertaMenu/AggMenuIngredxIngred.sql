DROP TRIGGER IF EXISTS ControllaIngredientiMenu1 ;
DELIMITER $$

CREATE TRIGGER ControllaIngredientiMenu1
BEFORE UPDATE ON OffertaMenu FOR EACH ROW
begin

IF (New.DataScadenza IS NOT NULL AND New.DataIntroduzione>New.DataScadenza) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='La Data di Introduzione è maggiore della data di scadenza!! ';

END IF;

SET @numingr = (SELECT COUNT(distinct PS.IdIngrediente,Ps.Principale)AS NumeroIngredienti 
    FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
    WHERE (Cm.IdMenu=New.IdMenu AND PS.Principale=1));
     /* CONTA DEL NUMERO DI INGREDIENTI PRINCIPALI  IN UN MENU */

SET @NumeroDisponibilita = (SELECT COUNT(*)
FROM  (SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(PS.Dose_gr) AS DoseTot
	   FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
	   INNER JOIN Ingrediente I USING (IdIngrediente)
	   WHERE    CM.IdMenu = NEW.IdMenu  /*QUI VALORE */
       GROUP BY PS.IdIngrediente,PS.Principale
       HAVING Ps.Principale=1
       ) AS INec /* Tutti gli ingredienti principali Necessari per la ricetta */
       INNER JOIN
       
       ( SELECT I.IdIngrediente,I.Nome,SUM(Conf.Peso_gr) AS Qdisp
		 FROM (Sede S
		 INNER JOIN Magazzino M USING (IdSede)
		 INNER JOIN Scaffale Sc USING (IdMagazzino)
         INNER JOIN  (
					  SELECT C.IdScaffale,C.Ingrediente,C.Peso_gr 
					  FROM Confezione C
					  WHERE (C.DataArrivo+INTERVAL 3 DAY < NEW.DataIntroduzione AND C.Aspetto>=6 
                      AND C.DataScadenza >New.DataIntroduzione+INTERVAL 1 MONTH) ) AS Conf
         USING (IdScaffale)
		 INNER JOIN Ingrediente I ON Conf.Ingrediente = I.IdIngrediente) 
		 WHERE (S.IdSede = New.IdSede )
         /*  O SE NON ANCORA ARRIVATO AL PIU 3 GIORNI QUI VALORE @sede e datascadenza almeno maggiore di 1 mese +1 */
         GROUP BY I.IdIngrediente
		) AS IDISP  USING (IdIngrediente)
 /* Tutti gli ingredienti disponibili in magazzino che occorrono per la ricetta */
WHERE (INec.DoseTot*2<IDisp.Qdisp));


IF (@numingr<>@NumeroDisponibilita) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Il  Menu NON può entrare in vigore , Nel magazzino occorrono + Ingredienti Principali';
END IF;

/* ____________________________ */



SET @numingr= ( SELECT COUNT(*)
				FROM (
						SELECT  distinct PS.IdIngrediente 
						FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
						WHERE PS.IdIngrediente IS NOT NULL AND CM.IDMENU=NEW.IDMenu

					UNION
						Select Distinct PS.IdIngrediente
						FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
						INNER JOIN Variazione V USING (IdVariazione)
						INNER JOIN Ingrediente I ON I.IdIngrediente=V.Ingrediente
						WHERE  CM.IdMenu = NEW.IdMenu AND V.Ingrediente IS NOT NULL
					  ) AS TAB1  
				);


                
              
                
SET @NumeroDisponibilita=(SELECT COUNT(*)
FROM  
      (
		SELECT AAA.IdMenu,AAA.IdIngrediente, AAA.Nome, SUM(AAA.DoseTot) AS DoseTot
			FROM (
	
				(
				SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(PS.Dose_gr) AS DoseTot
				FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
				INNER JOIN Ingrediente I USING (IdIngrediente)
				WHERE    CM.IdMenu = New.IdMenu  /*QUI VALORE */
				GROUP BY PS.IdIngrediente 
				)
       
				UNION 
				(
				SELECT CM.IdMenu,I.IdIngrediente,PS.Principale AS PrincipaleN, I.Nome, SUM(V.NuovaDose) AS DoseTot
				FROM (ComponeMenu CM NATURAL JOIN Piatto P) INNER JOIN procedimentostep PS USING (IdPiatto)
				INNER JOIN Variazione V USING (IdVariazione)
				INNER JOIN Ingrediente I ON I.IdIngrediente=V.Ingrediente
				WHERE    CM.IdMenu = New.IdMenu/*QUI VALORE */
				GROUP BY PS.IdIngrediente 
				)
			) AS AAA
		GROUP BY AAA.IdIngrediente 

	 )  AS INec
       
       
       /* Tutti gli ingredienti  Necessari per la ricetta (PROCEDIMENTOSTEP+VARIAZIONI) */
       INNER JOIN
       
       ( SELECT I.IdIngrediente,I.Nome,SUM(Conf.Peso_gr) AS Qdisp
		 FROM (Sede S
		 INNER JOIN Magazzino M USING (IdSede)
		 INNER JOIN Scaffale Sc USING (IdMagazzino)
         INNER JOIN  (
					  SELECT C.IdScaffale,C.Ingrediente,C.Peso_gr 
					  FROM Confezione C
					  WHERE (C.DataArrivo+INTERVAL 3 DAY < NEW.DataIntroduzione AND C.Aspetto>=6 
                      AND C.DataScadenza >New.DataIntroduzione+INTERVAL 1 MONTH) ) AS Conf
         USING (IdScaffale)
		 INNER JOIN Ingrediente I ON Conf.Ingrediente = I.IdIngrediente) 
		 WHERE (S.IdSede = New.IdSede )
         /*  O SE NON ANCORA ARRIVATO AL PIU 3 GIORNI QUI VALORE @sede e datascadenza almeno maggiore di 1 mese +1 */
         GROUP BY I.IdIngrediente
		) AS IDISP  USING (IdIngrediente)
 /* Tutti gli ingredienti disponibili in magazzino che occorrono per la ricetta */
WHERE (INec.DoseTot*2<IDisp.Qdisp));

                
IF (@numingr<>@NumeroDisponibilita) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Il Piatto NON Può entrare in Menu, Nel magazzino occorrono + Ingredienti';
END IF;        

END $$

DELIMITER ;