/* Creazione Tabella Sala */
CREATE TABLE IF NOT EXISTS Sala (
    IDSala INT AUTO_INCREMENT NOT NULL,
    IdSede VARCHAR(10),
    PRIMARY KEY (IDSala),
    CONSTRAINT FK_SedeSala FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/*Creazione Tabella Tavolo */
CREATE TABLE IF NOT EXISTS Tavolo (
    IDTavolo INT AUTO_INCREMENT NOT NULL,
    NumeroPosti INT DEFAULT 0,
    IDSala INT,
    PRIMARY KEY (IDTavolo),
    CONSTRAINT FK_Sala FOREIGN KEY (IDSala)
        REFERENCES Sala (IDSala)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* Creazione Tabella Comanda */
CREATE TABLE IF NOT EXISTS Comanda (
    IDComanda varchar(6) NOT NULL,
    Time_Stamp TIMESTAMP(6),
    Stato VARCHAR(15) DEFAULT 'Nuova',
    TipoTakeAway BOOLEAN DEFAULT FALSE,
    Prezzo INT,
    IDTavolo INT,
    PRIMARY KEY (IDComanda),
    CONSTRAINT FK_Tavolo FOREIGN KEY (IDTavolo)
        REFERENCES Tavolo (IDTAvolo)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/*Creazione Tabella Ordine
Create table if not exists Ordine (
	IDOrdinde INT auto_increment not null,
    Quantità int default 1,
    StatoPiatto varchar ( 15 ) default 'Attesa',
    VariazionePiatto boolean default false,
	IDComanda int,
    IDPiatto int,
    primary key ( IDOrdine )
    constraint FK_Comanda Foreign key ( IDComanda )
		references Comanda ( IDComanda )
        on update cascade on delete cascade
	constraint FK_PiattoOrdinato foreign key ( IDPiatto )
		references Piatto ( IDPiatto )
		on update cascade on delete set null*/
    
/* Creazione Tabella Prenotazione */ 
CREATE TABLE IF NOT EXISTS Prenotazione (
    DataPrenotazione DATE NOT NULL,
    OraPrenotazione TIMESTAMP() NOT NULL,
    SedePrenotazione VARCHAR(10) NOT NULL,
    NumeroPersone INT NOT NULL,
    Evento BOOLEAN DEFAULT FALSE,
    IDTavolo INT,
    CodiceFiscale VARCHAR(16) NOT NULL,
    PRIMARY KEY (DataPrenotazione , OraPrenotazione , IDTavolo),
    CONSTRAINT FK_TavoloPrenotato FOREIGN KEY (IDTavolo)
        REFERENCES Tavolo (IDTavolo)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Cliente FOREIGN KEY (CodiceFiscale)
        REFERENCES Cliente (CodiceFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_SedePrenotazione FOREIGN KEY (SedePrenotazione)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* Creazione Tabella Cliente */
CREATE TABLE IF NOT EXISTS Cliente (
    CodiceFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(30),
    Nome VARCHAR(30),
    PRIMARY KEY (CodiceFiscale)
);
	
/* Creazione Tabella Telefono */
CREATE TABLE IF NOT EXISTS Telefono (
    Numero INT NOT NULL,
    Intestatario VARCHAR(16) NOT NULL,
    PRIMARY KEY (Numero),
    CONSTRAINT FK_Intestatario FOREIGN KEY (Intestatario)
        REFERENCES Cliente (CodiceFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE
);      

/* Creazione Tabella Account */
CREATE TABLE IF NOT EXISTS Account (
    Nickname VARCHAR(30) NOT NULL,
    Password_ VARCHAR(16) NOT NULL,
    Proprietario VARCHAR(16) NOT NULL UNIQUE,
    DataRegistrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DataNascita DATE,
    Sesso VARCHAR(1),
    Affidabilità INT,
    Ban BOOLEAN DEFAULT 0,
    Città VARCHAR(5),
    PRIMARY KEY (Nickname),
    CONSTRAINT FK_Proprietario FOREIGN KEY (Proprietario)
        REFERENCES Cliente (CodiceFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Residenza FOREIGN KEY (Città)
        REFERENCES Luogo (Cap)
        ON UPDATE CASCADE ON DELETE SET NULL
);
    
/* Creazione Tabella Evento */
CREATE TABLE IF NOT EXISTS Evento (
    IDEvento VARCHAR(6) NOT NULL,
    DataEvento DATE,
    Descrizione TINYTEXT NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    NumeroPartecipanti INT DEFAULT 0,
    AutoreEvento VARCHAR(30),
    PRIMARY KEY (IDEvento),
    CONSTRAINT FK_AutoreEvento FOREIGN KEY (AutoreEvento)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL
);
        
/* Creazione Tabella PartecipazioneEvento */
CREATE TABLE IF NOT EXISTS PartecipazioneEvento (
    Partecipante VARCHAR(16),
    Evento VARCHAR(6),
    PRIMARY KEY (Partecipante , Evento),
    CONSTRAINT FK_Partecipante FOREIGN KEY (Partecipante)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Evento FOREIGN KEY (Evento)
        REFERENCES Evento (IDEvento)
        ON UPDATE CASCADE ON DELETE CASCADE
);
    
    
/* Creazione Tabella Nuovo Piatto */
CREATE TABLE IF NOT EXISTS NuovoPiatto (
    IDNuovoPiatto VARCHAR(6) NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    Procedimento TINYTEXT,
    AutoreNuovoPiatto VARCHAR(30),
    PRIMARY KEY (IDNuovoPiatto),
    CONSTRAINT FK_AutoreNuovoPiatto FOREIGN KEY (AutoreNuovoPiatto)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL
);
   
/* Creazione Tabella IngredienteNuovoPiatto */
CREATE TABLE IF NOT EXISTS IngredienteNuovoPiatto (
    NuovoPiatto VARCHAR(6) NOT NULL,
    IDIngrediente INT NOT NULL,
    PRIMARY KEY ( NuovoPiatto , IDingrediente),
    CONSTRAINT FK_NuovoPiatto FOREIGN KEY (NuovoPiatto)
        REFERENCES NuovoPiatto (IDNuovoPiatto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_IngredienteNuovoPiatto FOREIGN KEY (IDIngrediente)
        REFERENCES Ingrediente (Idingrediente)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
	
/* Creazione Tabella ValutaNuovoPiatto	*/	
CREATE TABLE IF NOT EXISTS ValutaNuovoPiatto (
    AutoreValutazioneNP VARCHAR(30) NOT NULL,
    NuovoPiattoValutato VARCHAR(6) NOT NULL,
    GradimentoNP FLOAT(3 , 2 ) NOT NULL,
    PRIMARY KEY (AutoreValutazioneNP , NuovoPiattoValutato),
    CONSTRAINT FK_AutoreValutazioneNP FOREIGN KEY (AutoreValutazioneNP)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_NuovoPiattoValutato FOREIGN KEY (NuovoPiattoValutato)
        REFERENCES NuovoPiatto (IDNuovoPiatto)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creazione Tabella NuovaVariazione */
CREATE TABLE IF NOT EXISTS NuovaVariazione (
    IDNuovaVariazione VARCHAR(6) NOT NULL,
    Descrizione TINYTEXT NOT NULL,
    PiattoModificato VARCHAR(10) NOT NULL,
    AutoreNuovaVariazione VARCHAR(30),
    PRIMARY KEY (IDNuovaVariazione),
    CONSTRAINT FK_PiattoModificato FOREIGN KEY (PiattoModificato)
        REFERENCES Piatto (IdPiatto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_AutoreNuovaVariazione FOREIGN KEY (AutoreNuovaVariazione)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL
);

/* Creazione Tabella ValutaNuovaVariazione */
CREATE TABLE IF NOT EXISTS ValutaNuovaValutazione (
    AutoreValutazioneNV VARCHAR(30) NOT NULL,
    NuovaVariazioneValutata VARCHAR(6) NOT NULL,
    GradimentoNV FLOAT(3 , 2 ) NOT NULL,
    PRIMARY KEY (AutoreValutazioneNV , NuovaVariazioneValutata),
    CONSTRAINT FK_AutoreValutazioneNV FOREIGN KEY (AutoreValutazioneNV)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_NuovaVariazioneValutata FOREIGN KEY (NuovaVariazioneValutata)
        REFERENCES NuovaVariazione (IDNuovaVariazione)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creazione Tabella Recensione */ 
CREATE TABLE IF NOT EXISTS Recensione (
    IDRecensione VARCHAR(6) NOT NULL,
    Testo TEXT,
    AutoreRecensione VARCHAR(30) NOT NULL,
    VotoGenerale FLOAT(3 , 2 ) NOT NULL,
    SedeRecensita VARCHAR(10) NOT NULL,
    PRIMARY KEY (IDRecensione),
    CONSTRAINT FK_AutoreRecensione FOREIGN KEY (AutoreRecensione)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_SedeRecensita FOREIGN KEY (SedeRecensita)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creazione Tabella PiattoRecensito */
CREATE TABLE IF NOT EXISTS PiattoRecensito (
    SoggettoRecensione VARCHAR(10) NOT NULL,
    Recensione VARCHAR(6) NOT NULL,
    Commento TINYTEXT NOT NULL,
    PRIMARY KEY (SoggettoRecensione , Recensione),
    CONSTRAINT FK_SoggettoRecensione FOREIGN KEY (SoggettoRecensione)
        REFERENCES Piatto (IdPiatto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_Recensione FOREIGN KEY (Recensione)
        REFERENCES Recensione (IDRecensione)
        ON UPDATE CASCADE ON DELETE CASCADE
);


/* Creazione Tabella ValutaRecensione */
CREATE TABLE IF NOT EXISTS ValutaRecensione (
    RecensioneValutata VARCHAR(6) NOT NULL,
    AutoreValutazioneRecensione VARCHAR(30) NOT NULL,
    Veridicità FLOAT(3 , 2 ) NOT NULL,
    Accuratezza FLOAT(3 , 2 ) NOT NULL,
    PRIMARY KEY (RecensioneValutata , AutoreValutazioneRecensione),
    CONSTRAINT FK_RecensioneValutata FOREIGN KEY (RecensioneValutata)
        REFERENCES Recensione (IDRecensione)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_AutoreValutazioneRecensione FOREIGN KEY (AutoreValutazioneRecensione)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE CASCADE
);
	
/* Creazione Tabella Direttore */
CREATE TABLE IF NOT EXISTS Direttore (
    IDDirettore VARCHAR(6) NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    DataAssunzione DATE,
    DataDimissini DATE,
    Stipendio INT,
    PRIMARY KEY (IDDirettore)
);

/* Creazione Tabella Questionario */
CREATE TABLE IF NOT EXISTS Questionario (
    IDDomanda INT AUTO_INCREMENT NOT NULL,
    AutoreDomanda VARCHAR(6),
    Domanda VARCHAR(150) NOT NULL,
    PRIMARY KEY (IDDomanda),
    CONSTRAINT FK_AutoreDomanda FOREIGN KEY (AutoreDomanda)
        REFERENCES Direttore (IDDirettore)
        ON UPDATE CASCADE ON DELETE SET NULL
);

/* Creazione Tabella Risposta */
CREATE TABLE IF NOT EXISTS Risposta (
    IDRisposta INT AUTO_INCREMENT NOT NULL,
    Risposta VARCHAR(50) NOT NULL,
    Domanda INT NOT NULL,
	Punteggio INT DEFAULT 0,
    PRIMARY KEY (IDRisposta),
    CONSTRAINT FK_Domanda FOREIGN KEY (Domanda)
        REFERENCES Questionario (IDDomanda)
        ON UPDATE CASCADE ON DELETE CASCADE
);
    
    
/* Creazione Tabella RispostaRecensione */
CREATE TABLE IF NOT EXISTS RispostaRecensione (
    Risposta INT NOT NULL,
    RecensioneQuestionario VARCHAR(6) NOT NULL,
    PRIMARY KEY (Risposta , RecensioneQuestionario),
    CONSTRAINT FK_Risposta FOREIGN KEY (Risposta)
        REFERENCES Risposta (IDRisposta)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_RecensioneQuestionario FOREIGN KEY (RecensioneQuestionario)
        REFERENCES Recensione (IDRecensione)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creazione Tabella Pony */
CREATE TABLE IF NOT EXISTS Pony (
    IDPony VARCHAR(6) NOT NULL,
    SedePony VARCHAR(10) NOT NULL,
    Mezzo INT,
    Stato VARCHAR(10) DEFAULT "Libero",
    PRIMARY KEY (IDPony),
    CONSTRAINT FK_SedePony FOREIGN KEY (SedePony)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* Creazione Tabella Comanda Take Away */
DROP TABLE IF EXISTS ComandaTakeAway;
CREATE TABLE IF NOT EXISTS ComandaTakeAway (
    IDComandaTA VARCHAR(6) NOT NULL,
    AccountComanda VARCHAR(30),
    Pony VARCHAR(6),
    Time_StampPartenza TIMESTAMP(6),
    Time_StampConsegna TIMESTAMP(6),
    Time_StampRientro TIMESTAMP(6),
    PRIMARY KEY (IDComandaTA),
    CONSTRAINT Fk_AccountComanda FOREIGN KEY (AccountComanda)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT Fk_Pony FOREIGN KEY (Pony)
        REFERENCES Pony (IDPony)
        ON UPDATE CASCADE ON DELETE SET NULL
);

    









