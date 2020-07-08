CREATE DATABASE IF NOT EXISTS ASSURAUTO;

CREATE TABLE IF NOT EXISTS CLIENTS(
CL_ID INT NOT NULL PRIMARY KEY,
CL_PRENOM VARCHAR(30) NOT NULL,
CL_NOM VARCHAR(30) NOT NULL,
CL_ADRESSE VARCHAR(30) NOT NULL,
CL_POSTALE VARCHAR(30) NOT NULL CHECK(CL_POSTALE = '06400'),
CL_VILLE VARCHAR(30) NOT NULL CHECK(CL_VILLE = 'Cannes'),
CL_COORDONNEES VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS CONTRAT(
CO_NUM INT NOT NULL PRIMARY KEY,
CO_DATE DATE NOT NULL,
CO_CATEGORIE VARCHAR(30),
CO_BONUS_MALUS VARCHAR(30),
CO_CLIENTS_FK INT NOT NULL,
FOREIGN KEY (CO_CLIENTS_FK) REFERENCES CLIENTS(CL_ID)
);