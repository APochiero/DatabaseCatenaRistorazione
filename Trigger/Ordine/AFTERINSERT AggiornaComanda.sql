/* TRIGGER AGGIORNA PREZZO DOPO INSERIMENTO ORDINE */
DROP TRIGGER IF EXISTS AggiornaPrezzoComanda;
DELIMITER $$
CREATE TRIGGER AggiornaPrezzoComanda 
AFTER INSERT ON Ordine FOR EACH ROW

BEGIN

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
	SET MESSAGE_TExT='PRoblemi con IL NULL NELLE QUERY';
END IF;

END $$
DELIMITER ;
