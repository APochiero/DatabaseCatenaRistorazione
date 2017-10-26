Delimiter $$

Create Trigger AumentaPunteggioRisposta
after insert on RispostaRecensione for each row 

begin

Update Risposta
SET Punteggio = Punteggio + 1
WHERE IDRisposta = New.Risposta;

END $$

Delimiter ;
