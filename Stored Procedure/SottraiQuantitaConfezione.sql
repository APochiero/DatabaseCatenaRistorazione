DROP PROCEDURE IF EXISTS SottraiQuantitaConfezione;

DELIMITER $$

CREATE PROCEDURE SottraiQuantitaConfezione( IN Ordine_ VARCHAR(6),INOUT DoseDaSottrarre INT )

BEGIN

DECLARE ConfezioneDaAggiornare_ VArCHAR(10);
DECLARE PesoAttuale_ INT;
DECLARE Finito INT DEFAULT 0;
DECLARE ElencoConfezioniDaAggiornare CURSOR FOR 

SELECT IDConfezione, QuantitaAttuale
FROM Temp_ConfezioneInUso
WHERE IDOrdine = Ordine_
ORDER BY StatoAttuale Desc;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET Finito=1;

Open ElencoConfezioniDaAggiornare;

preleva : LOOP

FETCH ElencoConfezioniDaAggiornare INTO ConfezioneDaAggiornare_, PesoAttuale_;

IF (finito=1) THEN 
LEAVE preleva; 
END IF;

IF ( DoseDaSottrarre >= PesoAttuale_ ) THEN
  SET DoseDaSottrarre = DoseDaSottrarre - PesoAttuale_;
  UPDATE Confezione
  SET Peso_gr = 0, Stato = "Esaurita"
  WHERE IDConfezione = ConfezioneDaAggiornare_;

ELSE
    UPDATE Confezione
	SET Peso_gr = Peso_gr - DoseDaSottrarre, Stato = "Parziale"
	WHERE IDConfezione = ConfezioneDaAggiornare_;
    SET DoseDaSottrarre = 0;
END IF;

DELETE FROM Temp_ConfezioneInUso
WHERE IDConfezione = ConfezioneDaAggiornare_;

END LOOP preleva;

CLOSE ElencoConfezioniDaAggiornare;
END $$
DELIMITER ;