DROP PROCEDURE AggiornaConfezioni;

DELIMITER $$

CREATE PROCEDURE AggiornaConfezioni( IN VAR_IDSede VARCHAR(10), IN VAR_IDOrdine VARCHAR(6), IN VAR_QuantitaOrdine INT )
BEGIN 

DECLARE IDSede_ VARCHAR (10);
DECLARE DoseUsata_ INT;
DECLARE IDOrdine_ VARCHAR(6);
DECLARE IDingrediente_ INT;
DECLARE Priorita_ INT;
DECLARE Principale_ BOOLEAN;
DECLARE Finito INT DEFAULT 0;

DECLARE ElencoIngredienti CURSOR FOR 

SELECT IDOrdine, Priorita, IDingrediente, Dose*VAR_QuantitaOrdine, Principale
FROM Temp_OrdinePriorita
WHERE IDOrdine =  VAR_IDOrdine;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET Finito=1;

open ElencoIngredienti;

preleva: LOOP

FETCH ElencoIngredienti INTO IDOrdine_, Priorita_, IDIngrediente_, DoseUsata_, Principale_;

IF (finito=1) THEN 
	LEAVE preleva; 
END IF;

IF ( IDIngrediente_ IS NOT NULL ) THEN 
	IF ( Principale_ = 0 ) THEN
		CALL CercaConfezioniDaUsare ( VAR_IDSede, DoseUsata_, IDOrdine_, IDIngrediente_ );
	ELSE 
		CALL CercaConfezioniBuoneDaUsare ( VAR_IDSede, DoseUsata_, IDOrdine_, IDIngrediente_ );
	END IF;
    CALL SottraiQuantitaConfezione (  IDOrdine_, DoseUsata_ );
END IF;
END LOOP Preleva;

CLOSE ElencoIngredienti;
END $$
DELIMITER ;
        
        
        
        
        
        
        
        
        
        
        
        
