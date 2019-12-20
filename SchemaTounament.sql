 Use master
go

DROP TABLE IF EXISTS TOURNAMENTS_CA_DEIDRE
go
Create DataBase TOURNAMENTS_CA_DEIDRE
go
USE TOURNAMENTS_CA_DEIDRE
GO

DROP SCHEMA IF EXISTS TOURNAMENTS;
go
CREATE SCHEMA TOURNAMENTS; 
GO

CREATE TABLE TOURNAMENTS.Tournament (
    TournamentId INT constraint PKTournament  PRIMARY KEY IDENTITY (1, 1),
    TournamentName VARCHAR (40) NOT NULL,
   DescriptionID VARCHAR (200) NOT NULL,
    TournamentAddress VARCHAR (60) NOT NULL,
    TournamentDate DATE NOT NULL,
	RegistrationCost Money  NOT NULL,
	SportType Varchar (30) NOT NULL,
	RegistrationCostDate Date,
	    );


CREATE TABLE TOURNAMENTS.Participant(
   ParticipantId INT constraint PKParticipant  PRIMARY KEY IDENTITY (1, 1),
    ParticipantName Varchar (30)  NOT NULL,
   BirthDate Date  NOT NULL,
    EmailAddreass Varchar (50)  NOT NULL,
    ParticipantPassword Varchar (30) NOT NULL,
	);


	CREATE TABLE TOURNAMENTS.Payment (
   PaidId INT constraint PKPaid  PRIMARY KEY IDENTITY (1, 1),
    AmoutPaid Money  NOT NULL,
   PaimentDate Date  NOT NULL,
    TournamentId INT  NOT NULL,
    ParticipantId INT NOT NULL,
	FOREIGN KEY (TournamentId) REFERENCES TOURNAMENTS.Tournament(TournamentId),
	FOREIGN KEY (ParticipantId) REFERENCES TOURNAMENTS.Participant(ParticipantId),
		    );


 
 --Payments Payment date must always be the current system date
 --To create Constrain criar codigo ALTER TABLE
 
ALTER TABLE TOURNAMENTS.Payment
add CONSTRAINT PaymentDateConstrait -- nome aleatorio 
DEFAULT GETDATE() for PaimentDate -- nome da coluna

-- Participants must be 16 years or older in order to register to any of these teams
ALTER TABLE TOURNAMENTS.Participant
ADD CONSTRAINT CHK_BirthDate --birthdate nome aleatorio
CHECK  (GETDATE()-  convert(DateTime,BirthDate) > = 16 ); --BirthDate repetir onome anterior que e o constrait
GO  

--create function

CREATE FUNCTION TOURNAMENTS.Formatdate --FormatDate nome aleatorio para  funcao que ira fazer o especifico formato
(
	@Date Date -- BirthDate porque se quer que a informacao fique como: date, month and year
)
RETURNS VARCHAR (50)-- PORQUE IRA RETORNAR EM NOME E NUMERO E COLOCAR O NUMERO DE CARACTERES
WITH RETURNS NULL ON NULL INPUT, 
	SCHEMABINDING 
AS
	BEGIN --COLOCAR A LOGICA ENTRE BEGIN E END
		DECLARE @OutputMonth Varchar (15)
		DECLARE @OutputDay VARCHAR (15)  
		DECLARE @OutputYear VARCHAR (15) 
		SELECT @OutputMonth = FORMAT(@Date, 'MMMM')
		SELECT @OutputDay = DAY(@Date)
		SELECT @OutputYear = YEAR(@Date)
							RETURN @OutputMonth +' '+ @OutputDay +' '+ @OutputYear
			END;
	GO

	DROP FUNCTION TOURNAMENTS.Formatdate
	GO

--CREATE STORE PROCEDURE 

--For Insert

CREATE PROCEDURE TOURNAMENTS.ParticipantInsert @ParticipantName varchar(30), @BirthDate DATE, 
@EmailAddreass varchar(50), @ParticipantPassword varchar(30)
AS
INSERT INTO TOURNAMENTS.Participant(ParticipantName, BirthDate, EmailAddreass, ParticipantPassword)
VALUES                                (@ParticipantName , @BirthDate , @EmailAddreass , @ParticipantPassword );
GO

--Inserir valores Julian etc usar store procedure
EXEC TOURNAMENTS.ParticipantInsert 'Julian' , '07/15/1985' , 'juliandavid@live.com' , '220010'

SELECT * FROM TOURNAMENTS.Participant
GO


--For Update
CREATE PROCEDURE TOURNAMENTS.ParticipantUpdate @ParticipantId int,  @ParticipantName varchar(30), @BirthDate DATE, 
@EmailAddreass varchar(50), @ParticipantPassword varchar(30)
AS
UPDATE TOURNAMENTS.Participant
SET ParticipantName = @ParticipantName, BirthDate = @BirthDate, EmailAddreass = @EmailAddreass
WHERE ParticipantId = @ParticipantId;
GO

--para testar a funcao digitar o codigo abaixo
EXEC TOURNAMENTS.ParticipantUpdate 1,'Julian David' , '07/15/1985' , 'juliandavid@live.com' , '220010'

SELECT * FROM TOURNAMENTS.Participant

GO
--For Delete
CREATE PROCEDURE TOURNAMENTS.ParticipantDelete @ParticipantId int 
AS
DELETE FROM TOURNAMENTS.Participant
WHERE ParticipantId = @ParticipantId;
GO

EXEC TOURNAMENTS.ParticipantDelete 1

SELECT * FROM TOURNAMENTS.Participant

GO

DROP TABLE TOURNAMENTS.Payment

DROP TABLE TOURNAMENTS.Tounarmnet

 DROP TABLE TOURNAMENTS.Participant