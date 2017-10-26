CREATE OR REPLACE VIEW ListaPiattiVenduti AS
select S.IdSede,M.IdMenu,P.IdPiatto,CM.Prezzo

FROM  Piatto P INNER JOIN ComponeMenu CM USING (IdPiatto)
	  INNER JOIN Menu M USING (IdMenu)
      INNER JOIN OffertaMenu OM USING (IdMenu)
      INNER JOIN Sede S Using(IdSede);

DROP PROCEDURE IF EXISTS VenditeGlobaliPiatti;	
DELIMITER $$

CREATE PROCEDURE VenditeGlobaliPiatti()
 BEGIN
  

CREATE TABLE IF NOT EXISTS MV_VenditeGlobaliPiatti
(

RANK INT,
IdSede VARCHAR(10),
IdMenu VARCHAR(20),
IdPiatto VARCHAR (10),
TOT_NUMORDINI INT,
TOT_ORDINI_LastMonth INT,
TOT_ORDINI_TutteLeSedi INT,
PrezzoMAX INT, 
PrezzoMIN INT,
MediaPrezzo DOUBLE,
RecensioniPositiveSede INT,
TOT_RECENS_SEDE  INT,
TOT_RECENSIONI int

);
truncate TABLE MV_VenditeGlobaliPiatti;
  
INSERT INTO mv_venditeglobalipiatti
(

	Select IF(@sede=TAB1.IdSede,
							IF (@num=TAB1.NUMORDINI,@rank:=@rank+LEAST(0,@gap:=@gap+1) ,
							@rank:=@rank+GREATEST(@gap,@gap:=1)+LEAST(0,@num:=TAB1.NUMORDINI)
                ),
                @rank:=1+LEAST(0,@sede:=TAB1.IdSede)+
						LEAST(0,@num:=TAB1.NUMORDINI)+
                        LEAST(0,@gap:=1)
		
		   )AS RANK,
           TAB1.IdSede,TAB1.IdMenu,TAB1.IdPiatto,TAB1.NUMORDINI AS TOT_NUMORDINI,
          ( SELECT SUM(O1.Quantita)
			FROM Ordine O1 INNER JOIN Comanda C2 USING (IdComanda)
          WHERE O1.IdPiatto=TAB1.IdPiatto AND 
          C2.Time_Stamp >= Current_timestamp - interval 1 month
          )AS TOT_ORDINI_LastMonth,
           
         (SELECT SUM(O1.Quantita)
          FROM Ordine O1
          WHERE O1.IdPiatto=TAB1.IdPiatto
          )AS TOT_ORDINI_TutteLeSedi,
           
        (SELECT MAX(Prezzo)
		 FROM componemenu
		 WHERE IdPiatto=TAB1.IdPiatto
		)AS PrezzoMAX,
        (SELECT MIN(Prezzo)
		 FROM componemenu
		 WHERE IdPiatto=TAB1.IdPiatto
		)AS PrezzoMIN ,
        (SELECT AVG(Prezzo)
		 FROM componemenu
		 WHERE IdPiatto=TAB1.IdPiatto
		)AS MediaPrezzo,
        
        ( SELECT COUNT(*)
		  FROM PiattoRecensito PR INNER JOIN recensione R ON PR.recensione=R.IDRecensione
		  WHERE PR.SoggettoRecensione=TAB1.IdPiatto AND R.SedeRecensita=TAB1.IdSede
				AND PR.Voto>=6
		)AS RecensioniPositiveSede,
        ( SELECT COUNT(*)
		  FROM PiattoRecensito PR INNER JOIN recensione R ON PR.recensione=R.IDRecensione
		  WHERE PR.SoggettoRecensione=TAB1.IdPiatto AND R.SedeRecensita=TAB1.IdSede
          )AS TOT_RECENS_SEDE,
		( SELECT COUNT(*)
		  FROM PiattoRecensito PR INNER JOIN recensione R ON PR.recensione=R.IDRecensione
		  WHERE PR.SoggettoRecensione=TAB1.IdPiatto 
		)AS TOT_RECENSIONI
          
        
	
		FROM  
		( SELECT @sede:='')AS RANK,

		(	SELECT TAB2.IdSede,TAB2.IdMenu,TAB2.IdPiatto, SUM(TAB2.NUMORDINI) AS NUMORDINI,
			TAB2.Prezzo AS Prezzo
			FROM (

					SELECT Lpv.IdSede,Lpv.IdPiatto,O.Quantita AS NUMORDINI, LPV.Prezzo,LPV.IdMenu
					FROM ListaPiattiVenduti  LPV INNER JOIN Ordine O USING (IdPiatto)
					INNER JOIN Comanda C USING (IdComanda)
					INNER JOIN Prenotazione P USING (IdTavolo)
					WHERE LPV.IdSede=P.SedePrenotazione

					UNION ALL /* MIRACCOMANDO QUESTO SE NO TRONCA I DUPLICATI E NON TORNANO I CONTI */

					SELECT Lpv1.IdSede,Lpv1.IdPiatto,O1.Quantita AS NUMORDINI,LPV1.Prezzo,LPV1.IdMenu
					FROM ListaPiattiVenduti  LPV1 INNER JOIN Ordine O1 USING (IdPiatto)
					INNER JOIN Comanda C1 USING (IdComanda)
					INNER JOIN comandatakeaway CTA ON C1.IdComanda=CTA.IDComandaTA
					WHERE LPV1.IdSede=CTA.IdSede

				) AS TAB2

			GROUP BY IdSede, IdPiatto
			ORDER BY (IdSede), NUMORDINI DESC 
		)AS TAB1 

)
;






END $$
DELIMITER ;
