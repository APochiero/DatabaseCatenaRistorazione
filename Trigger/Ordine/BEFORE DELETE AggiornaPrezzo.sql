/* AGGIORNAMENTO COMANDA QUANDO ELIMINO UN ORDINE IN ATTESA */
DROP TRIGGER IF EXISTS CancellaOrdine;
DELIMITER $$
CREATE TRIGGER CancellaOrdine
BEFORE DELETE ON Ordine FOR EACH ROW

BEGIN

/* CONSIGLIATO USARE UNA FUNZIONE CHE CALCOLA IL PREZZO VISTO CHE E' LA STESSA ANCHE PER L'UPDATE */

/* SI SUPPONE CHE UN ORDINE POSSA ESSERE CANCELLATO SOLO SE IN STATO ATTESA */

IF (OLD.Stato<>'Attesa' AND OLD.Stato<>'InElaborazione' ) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='L ordine non può essere eliminato TROPPO TARDI ';
END IF;

SET @tipo= ( SELECT C.TipoTakeAway
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
SET MESSAGE_TExT= 'PRoblemi con IL NULL NELLE QUERY RELATIVO A PREZZO O A SEDE';
END IF ;


END $$
DELIMITER ;