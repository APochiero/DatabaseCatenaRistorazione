DROP TRIGGER IF EXISTS DiminuisciPunteggioRisposta;
Delimiter $$
Create Trigger DiminuisciPunteggioRisposta
after DELETE on RispostaRecensione for each row 

begin

Update Risposta
SET Punteggio = Punteggio - 1
WHERE IDRisposta = OLD.Risposta;

END $$

Delimiter ;