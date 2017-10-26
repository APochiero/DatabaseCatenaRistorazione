CREATE OR REPLACE VIEW IngredientiDisponibiliPerSede AS

SELECT S.IdSede,I.IdIngrediente,Count(*)AS QuanteConf, SUM(C.Peso_gr)AS PesoTOT,MIN(C.DataScadenza)AS DataScadMinima
FROM Ingrediente I INNER JOIN Confezione C ON I.IdIngrediente=C.Ingrediente 
INNER JOIN Magazzino M Using (IdMagazzino)
INNER JOIN Sede S Using (IdSede)
WHERE C.Stato='Parziale' OR C.DataScadenza BETWEEN current_date AND current_date()+Interval 14 DAY
GROUP BY S.IdSede,I.IdIngrediente
;

CREATE OR REPLACE VIEW ElencoPiattiCONVOTO AS
/* PREFERENZE PIATTI MANGIATI IN OGNI SEDE BASATO SOLO SULLE RECENSIONI */
SELECT R.SedeRecensita AS Sede,P.IdPiatto, AVG(PR.Voto)AS MEDIA_VOTO
FROM Piatto P INNER JOIN piattorecensito PR ON P.IdPiatto=PR.SoggettoRecensione
	INNER JOIN RECENSIONE R ON R.IdRecensione=PR.Recensione
GROUP BY R.SedeRecensita,P.IdPiatto
HAVING MEDIA_VOTO>=6

;

DROP PROCEDURE IF EXISTS MagazzinoIntelligente;
DELIMITER $$
CREATE PROCEDURE MagazzinoIntelligente ()

BEGIN

DECLARE CONTA1 INT DEFAULT 0;
DECLARE CONTA2 INT DEFAULT 0;
DECLARE Finito INT DEFAULT 0;
DECLARE VAR_SEDE VARCHAR (10);
DECLARE VAR_PIATTO VARCHAR(20);
DECLARE DataScad DATE ;

DECLARE ElencoPiatti CURSOR FOR
select EPCV.Sede,EPCV.IdPiatto
FROM ElencoPiattiConVoto EPCV
WHERE EPCV.IdPiatto NOT IN ( SELECT EPO.IdPiatto
							 FROM mv_elencopiattiordinabili EPO
                             WHERE EPCV.Sede=EPO.IdSede AND EPO.IdPiatto=EPCV.IdPiatto );

DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito=1;

CREATE TABLE IF NOT EXISTS MV_MagazzinoIntelligente
(
Sede VARCHAR (10),
PiattoConsigliato VARCHAR (20),
GiornoScadenzaMassimo DATE

);

TRUNCATE TABLE MV_MagazzinoIntelligente;


OPEN ElencoPiatti;
preleva: loop
FETCH ElencoPiatti INTO VAR_SEDE,VAR_PIATTO;

IF ( Finito=1 )THEN 
LEAVE preleva;
END IF;


SET CONTA1= ( SELECT COUNT(Distinct p1.IdIngrediente)
						 FROM ProcedimentoStep P1
                        WHERE P1.IdPiatto=VAR_PIATTO
			) ;
            
SET CONTA2=	( SELECT COUNT(*)
			  FROM (
			
             SELECT Ps.IdIngrediente,SUM(Ps.Dose_gr)AS SommaNecess,IDPS.PesoTOT AS PESOTOTCONF
			 FROM procedimentostep PS INNER JOIN IngredientiDisponibiliPerSede IDPS 
			 ON PS.IdIngrediente=IDPS.IdIngrediente 
			 WHERE PS.IdPiatto=VAR_PIATTO AND IDPS.IdSede=VAR_SEDE AND PS.IdIngrediente IS NOT NULL
			 GROUP BY Ps.IdIngrediente
			 HAVING SommaNecess*2<PESOTOTCONF
             ) AS TAB1
			);
 SET DataScad= ( SELECT MIN(TAB1.Dscad)
				 FROM (
					SELECT Ps.IdIngrediente,SUM(Ps.Dose_gr)AS SommaNecess,IDPS.PesoTOT AS PESOTOTCONF,MIN(IDPS.DataScadMinima)AS Dscad
					FROM procedimentostep PS INNER JOIN IngredientiDisponibiliPerSede IDPS 
					ON PS.IdIngrediente=IDPS.IdIngrediente 
					WHERE PS.IdPiatto=VAR_PIATTO AND IDPS.IdSede=VAR_SEDE AND PS.IdIngrediente IS NOT NULL
					GROUP BY Ps.IdIngrediente
					HAVING SommaNecess*2<PESOTOTCONF
                    )AS TAB1
			   );
IF (CONTA1=CONTA2) THEN
INSERT INTO MV_MagazzinoIntelligente VALUES(VAR_SEDE,VAR_PIATTO,DataScad);
             
END IF;



END LOOP preleva;
CLOSE ElencoPiatti;




END $$
 