
/*Creazione LuogoProduzione */
DROP TABLE  IF EXISTS Luogo;
CREATE TABLE Luogo (
    `Cap` VARCHAR(5) NOT NULL,
    `Nome` VARCHAR(20) NULL,
    `Provincia` VARCHAR(20) NULL,
    `Regione` VARCHAR(20) NULL,
    `Nazione` VARCHAR(20) NULL,
    PRIMARY KEY (`Cap`)
);
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('50134', 'Rifredi', 'Firenze', 'Toscana', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('22100', 'Como', 'Como', 'Lombardia', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('89817', 'Briatico', 'Vibo Valentia', 'Calabria', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('00062', 'Bracciano', 'Roma', 'Lazio', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('41049', 'Sassuolo', 'Modena', 'Emilia Romagna', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('36012', 'Asiago', 'Vicenza', 'Veneto', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('72100', 'Brindisi', 'Brindisi', 'Puglia', 'Italia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('42000', 'Saint-Étienne', 'Loira', 'Rodano-Alpi', 'Francia');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('40210', 'Düsseldorf', 'Düsseldorf', 'Vestfalia', 'Germania');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('98520', 'Aberdeen', 'Aberdeen', 'Washington', 'Stati Uniti');
INSERT INTO `Progettobasididati`.`luogo` (`Cap`, `Nome`, `Provincia`, `Regione`, `Nazione`) VALUES ('20121', 'Milano', 'Milano', 'Lombardia', 'Italia');

/*Creazione Ingrediente*/

DROP TABLE  IF EXISTS Ingrediente;
CREATE TABLE Ingrediente (
    IdIngrediente INT AUTO_INCREMENT NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    Genere VARCHAR(20),
    TipoProduzione VARCHAR(20),
    LuogoProduzione VARCHAR(5),
    PRIMARY KEY (IdIngrediente),
    CONSTRAINT FK_LuogoProd FOREIGN KEY (LuogoProduzione)
        REFERENCES luogo (Cap)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Olio d\'Oliva', 'Condimento', 'Biologica', '22100');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Zucchine', 'Verdura', 'Intensiva', '41049');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Carne Di Manzo', 'Carne', 'Eterogenea', '47016');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Cioccolato', 'Dolce', 'Intensiva', '42000');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Trota Salmonata', 'Pesce', 'Iperintensiva ', '00062');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Emmental', 'Formaggio', 'Biologica', '36012');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Pomodori', 'Verdura', 'Estensiva', '41049');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Mela', 'Frutta', 'Biologica', '98520');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Pera', 'Frutta', 'Biologica', '98520');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Farina', 'Cerale', 'Intensiva', '50134');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Carne di Vitello', 'Carne', 'Estensiva', '42000');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Rigatoni', 'Pasta', 'Intensiva', '36012');
INSERT INTO `Progettobasididati`.`ingrediente` (`Nome`, `Genere`, `TipoProduzione`, `LuogoProduzione`) VALUES ('Sale', 'Condimento', 'Intensiva', '36012');

/*Creazione Allergene*/
DROP TABLE  IF EXISTS Allergene;
CREATE TABLE Allergene (
    NomeSostanza VARCHAR(50) PRIMARY KEY
);
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('ABC');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('02ADF');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('UE32');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('OOO11');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('MM22');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('LAQ33');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('VLM25');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('III');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('VAPE');
INSERT INTO `Progettobasididati`.`allergene` (`NomeSostanza`) VALUES ('AK47');

/*Creazione ContieneAllergeni*/
DROP TABLE  IF EXISTS ContieneAllergeni;
CREATE TABLE ContieneAllergeni (
    IdIngrediente INT,
    NomeSostanza VARCHAR(50),
    Quantita_gr INT NOT NULL,
    PRIMARY KEY (IdIngrediente , NomeSostanza),
    CONSTRAINT FK_Ingredienti FOREIGN KEY (IdIngrediente)
        REFERENCES Ingrediente (IdIngrediente)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Allergeni FOREIGN KEY (NomeSostanza)
        REFERENCES Allergene (NomeSostanza)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('2', 'AK47', '11');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('4', 'ABC', '50');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('4', 'LAQ33', '10');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('5', 'UE32', '25');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('6', 'VLM25', '15');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('6', 'AK47', '7');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('6', 'OOO11', '24');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('10', 'AK47', '33');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('10', '02ADF', '10');
INSERT INTO `Progettobasididati`.`contieneallergeni` (`IdIngrediente`, `NomeSostanza`, `Quantita_gr`) VALUES ('11', ' LAQ33', '10');



/*Creazione Produttore*/
DROP TABLE  IF EXISTS Produttore;
CREATE TABLE Produttore (
    IdProduttore VARCHAR(10),
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Telefono VARCHAR(10) NOT NULL,
    DataInizioAttività DATE,
    PRIMARY KEY (IdProduttore)
);
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('101020', 'Mario', 'Rossi', '3337856981', '1970-05-05');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('ABC123', 'Francesco', 'Amadori', '3481120350', '1951-02-04');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('1AAABB', 'Sergio', 'Poretti', '3391011123', '1976-04-11');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('AEIOUY', 'Tonio', 'Cartonio', '3350001112', '2003-09-15');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('010101', 'Mario', 'Desideri', '3381145012', '1963-07-25');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('EA9999', 'Marcelo', 'Rodriguez', '3448800111', '1985-01-11');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('Tr0N00', 'Tirion', 'Lannister', '0001112223', '2011-05-28');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('AA1240', 'John ', 'Smith', '4509977880', '1980-07-30');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('892424', 'Eusebio', 'Di Francesco', '3507788990', '2005-05-17');
INSERT INTO `Progettobasididati`.`produttore` (`IdProduttore`, `Nome`, `Cognome`, `Telefono`, `DataInizioAttività`) VALUES ('ET0011', 'Giovanni', 'Bauli', '3901120351', '1995-04-27');

/*Creazione Lotto*/
DROP TABLE  IF EXISTS Lotto;
CREATE TABLE Lotto (
    CodiceLotto VARCHAR(10),
    DataProduzione DATE NOT NULL,
    LuogoProduzione VARCHAR(5),
    IdProduttore VARCHAR(10),
    PRIMARY KEY (CodiceLotto),
    CONSTRAINT FK_LuogoProdLotto FOREIGN KEY (LuogoProduzione)
        REFERENCES luogo (Cap)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_IdProd FOREIGN KEY (IdProduttore)
        REFERENCES produttore (IdProduttore)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000001', '2015-06-13', '36012', '1AAABB');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000002', '2015-07-25', '41049', '1AAABB');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000003', '2015-07-15', '98520', 'AA1240');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000004', '2012-09-27', '47016', 'ABC123');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000005', '2014-07-21', '89817', '892424');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000006', '2015-03-25', '41049', 'AEIOUY');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000007', '2015-08-10', '00062', '101020');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000008', '2015-06-14', '50134', '010101');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000009', '2013-11-17', '40210', 'ET0011');
INSERT INTO `Progettobasididati`.`lotto` (`CodiceLotto`, `DataProduzione`, `LuogoProduzione`, `IdProduttore`) VALUES ('000010', '2014-01-31', '42000', '1AAABB');


/*Creazione Sede */
DROP TABLE  IF EXISTS Sede;
CREATE TABLE Sede (
    IdSede VARCHAR(10),
    Nome VARCHAR(50) NOT NULL,
    Location VARCHAR(5),
    Via VARCHAR(50) NOT NULL,
    Civico INT NOT NULL,
    OraApertura TIME,
    OraChiusura TIME,
    GiornoChiusura INT,
    Telefono VARCHAR(10) NOT NULL,
    SitoInternet VARCHAR(50),
    PRIMARY KEY (IdSede),
    CONSTRAINT FK_LuogoUbicazione FOREIGN KEY (Location)
        REFERENCES luogo (Cap)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `Progettobasididati`.`sede` (`IdSede`,`Nome`,`Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `GiornoChiusura`, `Telefono`, `SitoInternet`) VALUES ('PiPPo', 'Da Pippo', '20121', 'Dei Pini', '35', '12:30', '01:30', '2', '0283204519', 'www.ristopippo.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`,`Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('Ezio', 'Buongustaio', '50134', 'Cavur', '11', '18:30', '02:30', '0577902078', 'www.ilbuongustaio.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`,`Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('Mimmo', 'Da Mimmo', '89817', 'Garibaldi', '45', '19:00', '01:30', '0982457811', 'www.wmimmo.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`,`Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `GiornoChiusura`, `Telefono`, `SitoInternet`) VALUES ('SPQR', 'A Lazio', '00062', 'Del Popolo', '01', '12:00', '00:00', '4', '0658789022', 'www.lafamobona.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `GiornoChiusura`, `Telefono`, `SitoInternet`) VALUES ('AAAA', 'Le Ristorant', '42000', 'Les chateauxx', '21', '13:00', '03:00', '1', '0444112233', 'www.leristorant.fr');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('BBBCD', 'La Tavola Calda', '47016', 'Del Ceppo', '47', '18:30', '01:30', '0699451122', 'www.tavolacalda.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `GiornoChiusura`, `Telefono`, `SitoInternet`) VALUES ('9010S', 'La Taverna Del Riccio', '50134', 'Pesciatina', '3', '13:00', '00:00', '3', '0577699011', 'www.tavernadelricco.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `GiornoChiusura`, `Telefono`, `SitoInternet`) VALUES ('A4444', 'FastFood', '98520', 'GreenPark', '7', '14:30', '23:30', '4', '1234567890', 'www.fastfood.com');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('McDon1', 'McDonald', '40210', 'Doncheshen', '2', '06:30', '03:30', '2301248920', 'www.mcdonald.de');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('McDon2', 'McDonald', '50134', 'Del gatto', '10', '06:30', '03:30', '4780369771', 'www.mcdonald.it');
INSERT INTO `Progettobasididati`.`sede` (`IdSede`, `Nome`, `Location`, `Via`, `Civico`, `OraApertura`, `OraChiusura`, `Telefono`, `SitoInternet`) VALUES ('Burgher1', 'BurgherKing', '00062', 'Giraffa Blu', '126', '08:30', '23:30', '1122334455', 'www.burgherking.it');

/*Creazione Magazzino	*/
DROP TABLE  IF EXISTS Magazzino;
CREATE TABLE Magazzino (
    IdMagazzino VARCHAR(10),
    Nome VARCHAR(20),
    IdSede VARCHAR(10),
    PRIMARY KEY (IdMagazzino),
    CONSTRAINT FK_SedeMagazz FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0001', 'First', '200', 'McDon1');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0002', 'Second', '50', 'McDon1');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0003', 'Third', '25', 'McDon1');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0004', 'Primo', '300', '9010S');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0005', 'Alpha', '250', 'A4444');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0006', 'Le Prime', '158', 'AAAA');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0007', 'Primo', '140', 'BBBCD');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0008', 'Riserva', '50', 'BBBCD');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0009', 'Il solo', '500', 'Burgher1');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0010', 'Main', '135', 'Ezio');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0011', 'Prim', '243', 'McDon2');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0012', 'Sec', '147', 'McDon2');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0013', '1', '100', 'Mimmo');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0014', 'Il primo', '142', 'PiPPo');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0015', 'il Sec', '75', 'PiPPo');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0016', 'Er Primo', '216', 'SPQR');
INSERT INTO `Progettobasididati`.`magazzino` (`IdMagazzino`, `Nome`, `Capienza`, `IdSede`) VALUES ('0017', 'Er Secondo', '54', 'SPQR');

/*CREAZIONE SCAFFALE*/
DROP TABLE IF EXISTS Scaffale;
CREATE TABLE Scaffale (
    IdScaffale VARCHAR(20),
    QuantitaMax INT NOT NULL,
    IdMagazzino VARCHAR(10),
    PRIMARY KEY (IdScaffale),
    CONSTRAINT FK_Magazzino FOREIGN KEY (IdMagazzino)
        REFERENCES magazzino (IdMagazzino)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('AAAAA', '50', '0001');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('AAAAB', '50', '0001');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('AAAAC', '100', '0001');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('AAAAD', '50', '0002');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('AAAAE', '25', '0003');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('BBBBA', '100', '0004');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('BBBBB', '150', '0004');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('BBBBC', '50', '0004');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('CCCA', '100', '0005');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('CCCB', '150', '0005');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('DDDA', '100', '0009');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('DDDB', '100', '0009');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('DDDC', '100', '0009');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('DDDD', '100', '0009');
INSERT INTO `Progettobasididati`.`scaffale` (`IdScaffale`, `QuantitaMax`, `IdMagazzino`) VALUES ('DDDE', '100', '0009');







/*Creazione Confezione*/
DROP TABLE IF EXISTS Confezione;
CREATE TABLE Confezione (
    IdConfezione VARCHAR(20),
    Ingrediente INT NOT NULL,
    CodLotto VARCHAR(10) NOT NULL,
    Peso_gr INT NOT NULL,
    Prezzo_euro INT NOT NULL,
    DataAcquisto DATE NOT NULL,
    DataArrivo DATE NOT NULL,
    DataScadenza DATE NOT NULL,
    Stato VARCHAR(10) DEFAULT 'Completa',
    Aspetto INT DEFAULT 6,
    IdScaffale VARCHAR(20) NOT NULL,
    IdMagazzino VARCHAR(10),
    PRIMARY KEY (IdConfezione),
    CONSTRAINT FK_Ingrediente FOREIGN KEY (Ingrediente)
        REFERENCES Ingrediente (IdIngrediente)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_CodLotto FOREIGN KEY (CodLotto)
        REFERENCES Lotto (CodiceLotto)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_MagazzinoConfez FOREIGN KEY (IdMagazzino)
        REFERENCES magazzino (IdMagazzino)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_ScaffaleConfez FOREIGN KEY (IdScaffale)
        REFERENCES Scaffale (IdScaffale)
        ON UPDATE CASCADE ON DELETE NO ACTION
);


/*MANCA INSERIMENTO VALORI!*/

/*Creazione OggettoCucina*/
DROP TABLE IF EXISTS OggettoCucina;
CREATE TABLE OggettoCucina (
    IdOggetto VARCHAR(20),
    Nome VARCHAR(30) NOT NULL,
    Stato VARCHAR(12) DEFAULT 'Disponibile' NOT NULL,
    Tipo VARCHAR(12) DEFAULT 'Macchinario' NOT NULL,
    IdSede VARCHAR(10) NOT NULL,
    PRIMARY KEY (IdOggetto),
    CONSTRAINT FK_IdSedeOgg FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('ABCDEF', 'Tagliere', 'Disponibile', 'Attrezzatura', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Impasta1', 'Impastatrice', 'Disponibile', '', 'Macchinario', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Forn0', 'Forno', 'Disponibile', 'Macchinario', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Fornello001', 'Fornello', 'Disponibile', 'Attrezzatura', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Fornello002', 'Fornello', 'Disponibile', 'Attrezzatura', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Impasta1', 'Impastatrice', 'Disponibile', 'Macchinario', 'McDon1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Impasta2', 'Impastatrice', 'Disponibile', 'Macchinario', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Impasta3', 'Impastatrice', 'Guasto', 'Macchinario', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Lavello012', 'Lavello', 'Disponibile', 'Attrezzatura', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Piano010', 'Piano di Lavoro', 'Disponibile', 'Attrezzatura', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Piano011', 'Piano di Lavoro', 'Disponibile', 'Attrezzatura', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('FOrno2', 'Forno Microonde', 'Disponibile', 'Macchinario', 'BBBCD');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('TostaPane01', 'Tostapane', 'Disponibile', 'Macchinario', 'Burgher1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('FornelloB011', 'Fornello', 'Disponibile', 'Macchinario', 'Burgher1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('FornelloB022', 'Fornello', 'Guasto', 'Macchinario', 'Burgher1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('ImpastatoreB92', 'Impastatrice', 'Disponibile', 'Macchinario', 'Burgher1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Piano123', 'Piano di Lavoro', 'Disponibile', 'Attrezzatura', 'Burgher1');
INSERT INTO `Progettobasididati`.`oggettocucina` (`IdOggetto`, `Nome`, `Stato`, `Tipo`, `IdSede`) VALUES ('Lavello002', 'Lavello', 'Disponibile', 'Attrezzatura', 'Burgher1');



 /* Creazione Tabella Funzione */
DROP TABLE IF EXISTS Funzione;
CREATE TABLE Funzione (
    NomeFunzione VARCHAR(20),
    Descrizione VARCHAR(50) NOT NULL,
    PRIMARY KEY (NomeFunzione)
);
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Sostegno', 'Premette la lavorazione di ingredienti');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Congelamento', 'Mantiene Temperatura sotto una certa soglia');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Avvinamento', 'Pulisce i piatti consumati');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Riempimento', 'Riempie un contenitore di acqua');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Affettatura', 'Tagliare in piccole fette');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Tritatura', 'Tagliare in piccoli pezzi');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Risciacquo', 'Pulire Nuovamente');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Misurazione', 'Consiste nel misurare una quantità ');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Sterilizzazione', 'Pulizia Completa di una serie di Attrezzature');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Riscaldamento', 'Innalza la temperatura in un recipiente');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Scongelamento', 'Permette di scongelare ingredienti congelati');
INSERT INTO `Progettobasididati`.`funzione` (`NomeFunzione`, `Descrizione`) VALUES ('Miscelamento', 'Unisce uno o più ingredienti');

/* Creazione SvolgeFunzione */
DROP TABLE IF EXISTS SvolgeFunzione;
CREATE TABLE SvolgeFunzione (
    IdOggetto VARCHAR(20),
    NomeFunzione VARCHAR(20),
    PRIMARY KEY (IdOggetto , NomeFunzione),
    CONSTRAINT FK_IdOggFunz FOREIGN KEY (IdOggetto)
        REFERENCES oggettocucina (IdOggetto)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_NomeFunz FOREIGN KEY (NomeFunzione)
        REFERENCES funzione (NomeFunzione)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('ABCDEF', 'Affettatura');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('ABCDEF', 'Tritatura');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Congela1', 'Congelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Forn0', 'Riscaldamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Fornello001', 'Riscaldamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Fornello001', 'Scongelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Fornello002', 'Riscaldamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('FornelloB011', 'Scongelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('FornelloB022', 'Scongelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('FornelloB022', 'Riscaldamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('FOrno2', 'Scongelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('FOrno2', 'Riscaldamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Impasta1', 'Miscelamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Lavello002', 'Avvinamento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Lavello002', 'Riempimento');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Lavello002', 'Risciaquo');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Piano010', 'Sostegno');
INSERT INTO `Progettobasididati`.`svolgefunzione` (`IdOggetto`, `NomeFunzione`) VALUES ('Piano011', 'Sostegno');

/* Creazione Fase */
DROP TABLE IF EXISTS Fase;
CREATE TABLE Fase (
    IdFase VARCHAR(10),
    NomeFase VARCHAR(20) NOT NULL,
    PRIMARY KEY (IdFase)
);
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Cott001', 'Cottura');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Figg001', 'Friggitura');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Cott002', 'Cottura Lenta');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Cott003', 'Cottura Rapida');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Trita001', 'Tritatura');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Bollit001', 'Bollitura');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Spiana001', 'Spianatura Grossa');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Spiana002', 'Spianatura Media');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Lievita001', 'Lievitazione');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Rifini001', 'Rifinitura Rapida');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Rifini002', 'Rifinitura Completa');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Mescola01', 'Mescolare');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Taglia02', 'Tagliare');
INSERT INTO `Progettobasididati`.`fase` (`IdFase`, `NomeFase`) VALUES ('Aggiunta01', 'Aggiunta ingrediente');

/* Creazione UtilizzoFase */
DROP TABLE IF EXISTS UtilizzoFase;
CREATE TABLE UtilizzoFase (
    IdOggetto VARCHAR(20),
    IdFase VARCHAR(10),
    PRIMARY KEY (IdOggetto , IdFase),
    CONSTRAINT FK_OggettoCucina FOREIGN KEY (IdOggetto)
        REFERENCES OggettoCucina (IdOggetto)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_FaseCucina FOREIGN KEY (IdFase)
        REFERENCES Fase (IdFase)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('ABCDEF', 'Trita001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('ABCDEF', 'Taglia02');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Forn0', 'Cott002');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Fornello001', 'Cott001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Fornello001', 'Cott003');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Fornello002', 'Cott001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Fornello002', 'Cott002');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Fornello002', 'Cott003');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('FornelloB011', 'Bollit001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('FornelloB022', 'Cott001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('FOrno2', 'Cott003');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Impasta1', 'Mescola01');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Impasta1', 'Rifini001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Impasta2', 'Mescola01');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Impasta3', 'Mescola01');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Piano010', 'Trita001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Piano010', 'Lievita001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Piano011', 'Lievita001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('TostaPane01', 'Cott003');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Piano123', 'Spiana001');
INSERT INTO `Progettobasididati`.`utilizzofase` (`IdOggetto`, `IdFase`) VALUES ('Piano123', 'Spiana002');


/* Creazione Menu */
DROP TABLE IF EXISTS Menu;
CREATE TABLE Menu (
    IdMenu VARCHAR(20),
    Nome VARCHAR(40) NOT NULL,
    PRIMARY KEY (IdMenu)
);

INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('HMeal', 'Happy Meal');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Smart ', 'Smart Eating');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('HMeal2', 'Happy Meal');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('CBO', 'Chicken Bacon Orion');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Mc Menu', 'Mc Menu');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Easy ', 'Easy Menu');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Salads', 'Vegetariano');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Classico', 'Classici Piatti Locali');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Special', 'Piatti Speciali');
INSERT INTO `Progettobasididati`.`menu` (`IdMenu`, `Nome`) VALUES ('Kids Meal', 'Pasti per Bambini');


/* Creazione OffertaMenu */
DROP TABLE IF EXISTS OffertaMenu;
CREATE TABLE OffertaMenu (
    IdSede VARCHAR(10),
    IdMenu VARCHAR(20),
    DataIntroduzione DATE NOT NULL,
    DataScadenza DATE,
    PRIMARY KEY (IdSede , IdMenu),
    CONSTRAINT FK_OffertaSede FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_OffertaMenu FOREIGN KEY (IdMenu)
        REFERENCES Menu (IdMenu)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('9010S', 'Classico', '2015-08-20');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`, `DataScadenza`) VALUES ('A4444', 'CBO', '2014-06-26', '2015-07-20');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('A4444', 'Smart ', '2015-07-21');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('AAAA', 'Salads', '2015-03-01');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('BBBCD', 'Classico', '2015-01-01');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`, `DataScadenza`) VALUES ('Burgher1', 'Kids Meal', '2015-06-10', '2015-08-15');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`, `DataScadenza`) VALUES ('Burgher1', 'Special', '2015-08-16', '2015-12-31');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('Ezio', 'Classico', '2015-04-25');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`, `DataScadenza`) VALUES ('McDon1', 'HMeal', '2012-11-11', '2013-05-04');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`, `DataScadenza`) VALUES ('McDon1', 'HMeal2', '2013-05-05', '2013-08-12');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('McDon1', 'Mc Menu', '2013-08-12');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('McDon2', 'Mc Menu', '2014-07-22');
INSERT INTO `Progettobasididati`.`offertamenu` (`IdSede`, `IdMenu`, `DataIntroduzione`) VALUES ('Mimmo', 'CBO', '2014-10-1');



/* Creazione Piatto */
DROP TABLE IF EXISTS Piatto;
CREATE TABLE Piatto (
    IdPiatto VARCHAR(10) NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    Genere VARCHAR(15) NOT NULL,
    Ricetta VARCHAR(255),
    PRIMARY KEY (IdPiatto)
);
INSERT INTO `Progettobasididati`.`piatto` (`IdPiatto`, `Nome`, `Genere`, `Ricetta`) VALUES ('PizzaM', 'Pizza Margherita', 'Pizze', '(Farina,Sale,Olio,Livito,Pomodoro,Mozzarella)');
INSERT INTO `Progettobasididati`.`piatto` (`IdPiatto`, `Nome`, `Genere`, `Ricetta`) VALUES ('PastaS', 'Pasta al Ragù', 'Primo', '(Rigatoni Emiliani,Ragù Genovese)');



/*Creazione ComponeMenu */
DROP TABLE IF EXISTS ComponeMenu;
CREATE TABLE ComponeMenu (
    IdMenu VARCHAR(20),
    IdPiatto VARCHAR(10),
    Prezzo INT NOT NULL,
    PRIMARY KEY (IdMenu , IdPiatto),
    CONSTRAINT FK_Menu FOREIGN KEY (IdMenu)
        REFERENCES Menu (IdMenu)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_ContienePiatto FOREIGN KEY (IdPiatto)
        REFERENCES Piatto (IdPiatto)
        ON UPDATE CASCADE ON DELETE NO ACTION
);


/*Creazione ProcedimentoStep */
DROP TABLE IF EXISTS ProcedimentoStep;
CREATE TABLE ProcedimentoStep (
    IdPiatto VARCHAR(10),
    Priorita INT,
    IdVariazione INT,
    IdFase VARCHAR(10) NOT NULL,
    Tempo_sec INT NOT NULL,
    IdIngrediente INT,
    Dose_gr INT,
    Principale BOOL DEFAULT 0,
    PRIMARY KEY (IdPiatto , Priorita),
    CONSTRAINT FK_IdPiattoStep FOREIGN KEY (IdPiatto)
        REFERENCES Piatto (IdPiatto)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_FaseStep FOREIGN KEY (IdFase)
        REFERENCES Fase (IdFase)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_IngredienteStep FOREIGN KEY (IdIngrediente)
        REFERENCES Ingrediente (IdIngrediente)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT FK_VarizioneStep FOREIGN KEY (IdVariazione)
        REFERENCES Variazione (IdVariazione)
        ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`) VALUES ('PizzaM', '1', 'Spiana001', '3600', '10', '500');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`) VALUES ('PizzaM', '2', 'Lievita001', '1200');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PizzaM', '3', 'Aggiunta01', '10', '1', '10', '1');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PizzaM', '4', 'Aggiunta01', '10', '7', '200', '1');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`) VALUES ('PizzaM', '5', 'Cott003', '2500');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PizzaM', '6', 'Rifini001', '20', '13', '20', '0');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PastaR', '1', 'Trita001', '60', '2', '10', '0');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PastaR', '2', 'Trita001', '60', '3', '400', '1');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`) VALUES ('PastaR', '3', 'Mescola01', '240');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`, `IdIngrediente`, `Dose_gr`, `Principale`) VALUES ('PastaR', '4', 'Aggiunta01', '10', '7', '50', '1');
INSERT INTO `Progettobasididati`.`procedimentostep` (`IdPiatto`, `Priorita`, `IdFase`, `Tempo_sec`) VALUES ('PastaR', '5', 'Cott002', '600');



/* Creazione Variazione */
DROP TABLE IF EXISTS Variazione;
CREATE TABLE Variazione (
    IdVariazione INT AUTO_INCREMENT,
    Ingrediente INT,
    NuovaDose INT,
    Fase VARCHAR(10),
    NuovoTempo INT NOT NULL,
    Tipologia CHAR(1) DEFAULT 'A',
    PRIMARY KEY (IdVariazione),
    CONSTRAINT FK_IngredienteVariazione FOREIGN KEY (Ingrediente)
        REFERENCES Ingrediente (IdIngrediente)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Fase FOREIGN KEY (Fase)
        REFERENCES Fase (IdFase)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* CREAZIONE SALA */
DROP TABLE IF  EXISTS Sala;
CREATE TABLE Sala (
    IDSala INT AUTO_INCREMENT NOT NULL,
    IdSede VARCHAR(10),
    PRIMARY KEY (IDSala),
    CONSTRAINT FK_SedeSala FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* Creazione Tavolo */
DROP TABLE IF EXISTS Tavolo;
CREATE TABLE Tavolo (
    IDTavolo INT AUTO_INCREMENT NOT NULL,
    NumeroPosti INT DEFAULT 0,
    IDSala INT,
    PRIMARY KEY (IDTavolo),
    CONSTRAINT FK_Sala FOREIGN KEY (IDSala)
        REFERENCES Sala (IDSala)
        ON UPDATE CASCADE ON DELETE NO ACTION
);




/* Creazione Comanda */
DROP TABLE IF EXISTS Comanda;
CREATE TABLE Comanda (
    IDComanda VARCHAR(6) NOT NULL,
    Time_Stamp TIMESTAMP(6),
    Stato VARCHAR(15) DEFAULT 'Nuova',
    TipoTakeAway BOOLEAN DEFAULT FALSE,
    Prezzo INT NOT NULL DEFAULT 0,
    IDTavolo INT,
    PRIMARY KEY (IDComanda),
    CONSTRAINT FK_Tavolo FOREIGN KEY (IDTavolo)
        REFERENCES Tavolo (IDTAvolo)
        ON UPDATE CASCADE ON DELETE NO ACTION
);


/* Creazione Ordine*/
DROP TABLE IF EXISTS Ordine;
CREATE TABLE IF NOT EXISTS Ordine (
    IdOrdine VARCHAR(6) NOT NULL,
    Quantita INT DEFAULT 1,
    Stato VARCHAR(15) DEFAULT 'Attesa',
    Variazione BOOLEAN DEFAULT FALSE,
    IdComanda VARCHAR(6) NOT NULL,
    IDPiatto VARCHAR(10) NOT NULL,
    PRIMARY KEY (IdOrdine),
    CONSTRAINT FK_ComandaOrdine FOREIGN KEY (IdComanda)
        REFERENCES Comanda (IDComanda)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_IdPiattoOrd FOREIGN KEY (IdPiatto)
        REFERENCES Piatto (IdPiatto)
        ON UPDATE CASCADE ON DELETE NO ACTION
);



/* Creazione ContieneVariazione */
DROP TABLE IF EXISTS ContieneVariazione;
CREATE TABLE ContieneVariazione (
    IdOrdine VARCHAR(6),
    IdVariazione INT,
    PRIMARY KEY (IdOrdine , IdVariazione),
    CONSTRAINT FK_OrdineVar FOREIGN KEY (IdOrdine)
        REFERENCES Ordine (IdOrdine)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT FK_Var FOREIGN KEY (IdVariazione)
        REFERENCES Variazione (IdVariazione)
        ON UPDATE CASCADE ON DELETE NO ACTION
);
/* Creazione Cliente */
DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente (
    CodiceFiscale VARCHAR(16) NOT NULL,
    Cognome VARCHAR(30),
    Nome VARCHAR(30),
    PRIMARY KEY (CodiceFiscale)
);



/* Creazione Prenotazione */
DROP TABLE IF EXISTS Prenotazione;
CREATE TABLE Prenotazione (
    DataPrenotazione DATE NOT NULL,
    OraPrenotazione TIME(0) NOT NULL,
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


/* Creazione Telefono  */
DROP TABLE IF EXISTS Telefono;
CREATE TABLE Telefono (
    Numero INT NOT NULL,
    Intestatario VARCHAR(16) NOT NULL,
    PRIMARY KEY (Numero),
    CONSTRAINT FK_Intestatario FOREIGN KEY (Intestatario)
        REFERENCES Cliente (CodiceFiscale)
        ON UPDATE CASCADE ON DELETE CASCADE
);      
/* Creazione Account */
DROP TABLE IF  EXISTS Account;
CREATE TABLE IF NOT EXISTS Account (
    Nickname VARCHAR(30) NOT NULL,
    Password_ VARCHAR(16) NOT NULL,
    Proprietario VARCHAR(16) NOT NULL,
    DataNascita DATE,
    Sesso VARCHAR(1),
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


/* Creazione Evento */
DROP TABLE IF EXISTS Evento;
CREATE TABLE Evento (
    IDEvento VARCHAR(6) NOT NULL,
    DataEv DATE,
    Descrizione TINYTEXT NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    NumeroPartecipanti INT DEFAULT 0,
    AutoreEvento VARCHAR(30),
    PRIMARY KEY (IDEvento),
    CONSTRAINT FK_AutoreEvento FOREIGN KEY (AutoreEvento)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL
);


/*Creazione PartecipazioneEvento*/
DROP TABLE IF EXISTS PartecipazioneEvento;
CREATE TABLE PartecipazioneEvento (
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
DROP TABLE IF EXISTS NuovoPiatto;
CREATE TABLE NuovoPiatto (
    IDNuovoPiatto VARCHAR(6) NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    Procedimento TINYTEXT,
    AutoreNuovoPiatto VARCHAR(30),
    PRIMARY KEY (IDNuovoPiatto),
    CONSTRAINT FK_AutoreNuovoPiatto FOREIGN KEY (AutoreNuovoPiatto)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE SET NULL
);

/*Ingrediente NuovoPiatto */
DROP TABLE IF EXISTS IngredienteNuovoPiatto;
CREATE TABLE IngredienteNuovoPiatto (
    NuovoPiatto VARCHAR(6) NOT NULL,
    IDIngrediente INT NOT NULL,
    PRIMARY KEY (NuovoPiatto , IDingrediente),
    CONSTRAINT FK_NuovoPiatto FOREIGN KEY (NuovoPiatto)
        REFERENCES NuovoPiatto (IDNuovoPiatto)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK_IngredienteNuovoPiatto FOREIGN KEY (IDIngrediente)
        REFERENCES Ingrediente (Idingrediente)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/* Creazione ValutazioneNuovoPiatto */
DROP TABLE IF EXISTS ValutaNuovoPiatto;
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

/* Creazione NuovaVariazione */
DROP TABLE IF EXISTS NuovaVariazione;
CREATE TABLE NuovaVariazione (
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


/* Creazione ValutaNuovaValutazione */
DROP TABLE IF EXISTS ValutaNuovaValutazione;
CREATE TABLE ValutaNuovaValutazione (
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

/* Creazione Recensione */
DROP TABLE IF EXISTS Recensione;
CREATE TABLE Recensione (
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


/* Creazione Piatto Recensito */
DROP TABLE IF EXISTS PiattoRecensito;
CREATE TABLE PiattoRecensito (
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

/* Creazione ValutaRecensione */
DROP TABLE IF EXISTS ValutaRecensione;
CREATE TABLE ValutaRecensione (
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

/* Creazione Direttore */
DROP TABLE IF EXISTS Direttore;
CREATE TABLE Direttore (
    IDDirettore VARCHAR(6) NOT NULL,
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    DataAssunzione DATE,
    DataDimissini DATE,
    Stipendio INT,
    PRIMARY KEY (IDDirettore)
);

/* Creazione Questionario */

DROP TABLE IF EXISTS Questionario;
CREATE TABLE Questionario (
    IDDomanda INT AUTO_INCREMENT NOT NULL,
    AutoreDomanda VARCHAR(6),
    Domanda VARCHAR(150) NOT NULL,
    PRIMARY KEY (IDDomanda),
    CONSTRAINT FK_AutoreDomanda FOREIGN KEY (AutoreDomanda)
        REFERENCES Direttore (IDDirettore)
        ON UPDATE CASCADE ON DELETE SET NULL
);

/* Creazione Risposta */

DROP TABLE IF EXISTS Risposta;
CREATE TABLE Risposta (
    IDRisposta INT AUTO_INCREMENT NOT NULL,
    Risposta VARCHAR(50) NOT NULL,
    Domanda INT NOT NULL,
    Punteggio INT DEFAULT 0,
    PRIMARY KEY (IDRisposta),
    CONSTRAINT FK_Domanda FOREIGN KEY (Domanda)
        REFERENCES Questionario (IDDomanda)
        ON UPDATE CASCADE ON DELETE CASCADE
);

/* Creazione RispostaRecensione */
DROP TABLE IF EXISTS RispostaRecensione;
CREATE TABLE RispostaRecensione (
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


/*Creazione Pony */
CREATE TABLE IF NOT EXISTS Pony (
    IDPony VARCHAR(6) NOT NULL,
    SedePony VARCHAR(10) NOT NULL,
    Mezzo INT,
    Stato VARCHAR(10) DEFAULT 'Libero',
    PRIMARY KEY (IDPony),
    CONSTRAINT FK_SedePony FOREIGN KEY (SedePony)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

/*Creazione ComandaTakeAway */
DROP TABLE IF EXISTS ComandaTakeAway;
CREATE TABLE IF NOT EXISTS ComandaTakeAway (
    IDComandaTA VARCHAR(6) NOT NULL,
    AccountComanda VARCHAR(30) NOT NULL,
    IdSede VARCHAR(10) NOT NULL,
    Pony VARCHAR(6),
    Time_StampPartenza TIMESTAMP(6) DEFAULT NULL,
    Time_StampConsegna TIMESTAMP(6) DEFAULT NULL,
    Time_StampRientro TIMESTAMP(6) DEFAULT NULL,
    PRIMARY KEY (IDComandaTA),
    CONSTRAINT Fk_AccountComanda FOREIGN KEY (AccountComanda)
        REFERENCES Account (Nickname)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT Fk_Pony FOREIGN KEY (Pony)
        REFERENCES Pony (IDPony)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT Fk_SedeComTA FOREIGN KEY (IdSede)
        REFERENCES Sede (IdSede)
        ON UPDATE CASCADE ON DELETE NO ACTION
);


/* AFFINCHE GLI  EVENT FUNZIONINO VA LANCIATO QUESTO COMANDO */

SET GLOBAL event_scheduler = ON
