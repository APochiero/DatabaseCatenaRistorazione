SELECT 
    Rec.IDRecensione, AutoreRecensione, AspettiNonGraditi, SUM(ValoreRisposta) AS PunteggioQuestionario 
FROM
    Questionario Q
        INNER JOIN
    Risposta R ON Q.IDDomanda = R.Domanda
        INNER JOIN
    RispostaRecensione RR ON R.IDRisposta = RR.Risposta
        INNER JOIN
    Recensione Rec ON Rec.IDRecensione = RR.RecensioneQuestionario
        INNER JOIN
    (SELECT 
        GROUP_CONCAT(Q.Domanda) AS AspettiNonGraditi,
            RecensioneQuestionario
    FROM
        Questionario Q
    INNER JOIN Risposta R ON Q.IDDomanda = R.Domanda
    INNER JOIN RispostaRecensione RR ON R.IDRisposta = RR.Risposta
    WHERE
        R.ValoreRisposta < 3
    GROUP BY RR.RecensioneQuestionario) AS D ON Rec.IDRecensione = D.RecensioneQuestionario
        INNER JOIN
    (SELECT 
        A.Nickname, P.SedePrenotazione 
    FROM
        Account A
    INNER JOIN Cliente C ON A.Proprietario = C.CodiceFiscale
    INNER JOIN Prenotazione P USING (CodiceFiscale)
    GROUP BY NickName, SedePrenotazione
    HAVING COUNT(*) >= 2) AS AccountFedele ON AccountFedele.NickName = Rec.AutoreRecensione
WHERE AccountFedele.SedePrenotazione = Rec.SedeRecensita
GROUP BY RR.RecensioneQuestionario
