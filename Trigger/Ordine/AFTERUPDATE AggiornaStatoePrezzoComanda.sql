
/* Aggiorna lo stato della comanda e l'eventuale prezzo se è stato modificato un piatto */
DROP TRIGGER IF EXISTS AggiornaStatoePrezzoComanda;
DELIMITER $$
CREATE TRIGGER AggiornaStatoePrezzoComanda 
AFTER UPDATE ON Ordine FOR EACH ROW

BEGIN


SET @PiattiComanda = ( SELECT 
							COUNT(*)
					   FROM
							Ordine
					   WHERE
							IDComanda = NEW.IDComanda );

SET @PiattiInPreparazione = ( SELECT 
									COUNT(*)
							  FROM
									Ordine
							  WHERE
									IDComanda = NEW.IDComanda
							    AND Stato = 'InPreparazione' );
                                
SET @PiattiServizio = ( SELECT 
							COUNT(*)
						FROM
							Ordine
						WHERE
							IDComanda = NEW.IDComanda
						AND Stato = 'Servizio' );
                        
IF ( @PiattiInPreparazione > 0 AND @PiattiServizio = 0  ) THEN
	UPDATE Comanda C
    SET Stato = 'InPreparazione'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;    

IF ( @PiattiServizio > 0 AND @PiattiComanda > @PiattiServizio  ) THEN
	UPDATE Comanda C
	SET Stato = 'Parziale'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;

IF ( @PiattiServizio = @PiattiComanda ) THEN
	UPDATE Comanda C
	SET Stato = 'Evasa'
    WHERE C.IDComanda = NEW.IDComanda;
END IF;

/* QUI AVVIENE LA MODIFICA DEL PREZZO */

IF (NEW.IdPiatto<>OLD.IdPiatto OR NEW.Quantita <> OLD.Quantita) THEN
/* SOTTRAGGO IL PREZZO PRECEDENTE */
SET @tipo=   (  SELECT C.TipoTakeAway
				FROM  Comanda C
				WHERE  C.IdComanda=OLD.IdComanda);

IF (@tipo = 0) then

SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN Tavolo Using (IdTavolo)
                INNER JOIN Sala Sa USING (IdSala)
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=OLD.IdComanda
                );
else

SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN ComandaTakeAway CTA on C.IdComanda=CTA.IdComandaTA
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=OLD.IdComanda
                );
                
END IF;


SET @prezzo= (Select Cm.prezzo
		  FROM Ordine O INNER JOIN Piatto P USING (IdPiatto)
          INNER JOIN ComponeMenu CM USING (IdPiatto)
          INNER JOIN OffertaMenu OM USING (IdMenu)
          WHERE OM.IdSede=@idsede and P.IdPiatto=OLD.IdPiatto
          LIMIT 1);
          
IF(@prezzo IS NOT NULL AND @idSede IS NOT NULL) THEN
UPDATE Comanda
SET Prezzo=Prezzo-@prezzo*OLD.Quantita
WHERE IdComanda=OLD.IdComanda;

else

SIGNAL SQLSTATE '45000'
SET MESSAGE_TExT='PRoblemi con IL NULL NELLE QUERY';
END IF ;


/* AGGIUNGO IL NUOVO PREZZO */

SET @tipo= ( SELECT C.TipoTakeAway
				FROM  Comanda C
				WHERE  C.IdComanda=NEW.IdComanda);

IF (@tipo = 0) then

SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN Tavolo Using (IdTavolo)
                INNER JOIN Sala Sa USING (IdSala)
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=NEW.IdComanda);
else

SET @idsede= (  SELECT Se.IdSede
				FROM Comanda C INNER JOIN ComandaTakeAway CTA on C.IdComanda=CTA.IdComandaTA
                INNER JOIN Sede Se USING (IdSede)
				WHERE C.IdComanda=NEW.IdComanda);
                
END IF;

SET @prezzo= (Select Cm.prezzo
		  FROM Ordine O INNER JOIN Piatto P USING (IdPiatto)
          INNER JOIN ComponeMenu CM USING (IdPiatto)
          INNER JOIN OffertaMenu OM USING (IdMenu)
          WHERE OM.IdSede=@idsede  and P.IdPiatto=New.IdPiatto
LIMIT 1
);
          
IF(@prezzo IS NOT NULL AND @idSede IS NOT NULL) THEN
UPDATE Comanda
SET Prezzo=Prezzo+@prezzo* New.Quantita
WHERE IdComanda=New.IdComanda;

else

SIGNAL SQLSTATE '45000'
SET MESSAGE_TExT='PRoblemi con IL NULL NELLE QUERY RELATIVO AL PREZZO COMANDA!';
END IF;


END IF;

END $$
DELIMITER ;
