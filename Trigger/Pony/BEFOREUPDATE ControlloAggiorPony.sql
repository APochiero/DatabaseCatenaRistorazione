DROP TRIGGER IF EXISTS ControlloAggiorPony;
DELIMITER $$
CREATE TRIGGER ControlloAggiorPony
BEFORE UPDATE ON Pony FOR EACH ROW
BEGIN

/* IL TRIGGER SCATTA SOLO SE C'E UN CAMBIO DI STATO */

IF ( New.Stato <> "Libero" AND New.Stato <> "Occupato" ) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Stato Pony non valido';
END IF;

IF ( New.Mezzo <> 2 AND New.Mezzo <> 4 ) THEN
SIGNAL SQLSTATE '45000'
SET message_text='Mezzo non valido';
END IF;

/* CASO IN CUI TORNA QUINDI DIVENTA LIBERO E' TORNATO ALLA SEDE */

IF (NEW.Stato = 'Libero' ) THEN

	SET @Comanda_ = ( Select IDComandaTA
				      FROM ComandaTakeAway
					   WHERE Pony = New.IDPony AND 
                       NEW.SedePony=IdSede AND 
                  Time_stampRientro IS NULL );
    
    
    UPDATE ComandaTakeAway
    SET Time_stampRientro = CURRENT_TIMESTAMP
    WHERE Pony = NEW.IDPony AND IDComandaTA = @Comanda_ ;

END IF;

CREATE TEMPORARY TABLE IF NOT EXISTS  ComandeDaConsegnare
(
IdComandaTA VARCHAR(6),
Time_Stamp TimeStamp ,
IdSede VARCHAR(6),
NumPiatti int DEFAULT 0,
PRIMARY KEY (IdComandaTA)
);

SET @NuovaComanda=NULL;
SET @NuovaComanda= (SELECT IdComandaTA
					FROM ComandeDaConsegnare CDC
                    WHERE New.SedePony=CDC.IdSede
					ORDER BY Time_stamp
                    LIMIT 1);
SET @NumeroPiatti = (SELECT IdComandaTA
					FROM ComandeDaConsegnare CDC
                    WHERE New.SedePony=CDC.IdSede
					ORDER BY Time_stamp
                    LIMIT 1);
 /* CONTROLLA SE E' IL MEZZO GIUSTO CON CUI PORTARE I PIATTI */                   
IF ( @NumeroPiatti > 5 ) THEN
	SET @CercaMezzo = 4;
ELSE
	SET @CercaMezzo = 2;
END IF; 
   /* SE NON CI SONO COMANDE PER QUEL TIPO DI MEZZO IN QUELLA SEDE E' LIBERO
   ALTRIMENTI PRENDE LA PRIMA DA CONSEGNARE E LA PORTA */
IF (@NuovaComanda IS NOT NULL AND NEW.Mezzo>=@CercaMezzo) 
THEN
SET NEW.Stato='Occupato';
END IF;



END$$

DELIMiTER ;