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

CREATE TABLE TOURNAMENTS.TOUNARMENT (
    TournamentId INT constraint PKTournament  PRIMARY KEY IDENTITY (1, 1),
    TournamentName VARCHAR (40) NOT NULL,
   DescriptionID VARCHAR (200) NOT NULL,
    TournamentAddress VARCHAR (60) NOT NULL,
    TournamentDate DATE NOT NULL,
	RegistrationCost Money  NOT NULL,
	SportType Varchar (30) NOT NULL,
	RegistrationCostDate Date,
	    );


CREATE TABLE TOURNAMENTS.PARTICIPANT(
   ParticipantId INT constraint PKPARTICIPANT  PRIMARY KEY IDENTITY (1, 1),
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
	FOREIGN KEY (TournamentId) REFERENCES TOURNAMENTS.TOUNARMENT(TournamentId),
	FOREIGN KEY (ParticipantId) REFERENCES TOURNAMENTS.PARTICIPANT(ParticipantId),
		    );


 
 --Payments Payment date must always be the current system date
 
ALTER TABLE TOURNAMENTS.Payment
add CONSTRAINT PaymentDateConstrait -- nome aleatorio 
DEFAULT GETDATE() for PaimentDate -- nome da coluna

-- Participants must be 16 years or older in order to register to any of these teams
ALTER TABLE TOURNAMENTS.PARTICIPANT
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

	--CREATE STORE PROCEDURE FAZER AMANHA

	CREATE PROCEDURE DDRestaurantLatin.EmployeesInsert @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @Email varchar(60), @SinNumber varchar(20), @EmployeeAddress varchar(50), @BirthDate datetime
AS
INSERT INTO DDRestaurantLatin.Employees(FirstName, LastName, PhoneNumber, Email, SinNumber, EmployeeAddress, BirthDate)
VALUES                                (@FirstName, @LastName, @PhoneNumber, @Email, @SinNumber, @EmployeeAddress, @BirthDate);
GO

CREATE PROCEDURE DDRestaurantLatin.EmployeesUpdate @EmployeeId int, @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @Email varchar(60), @SinNumber varchar(20), @EmployeeAddress varchar(50), @BirthDate datetime
AS
UPDATE DDRestaurantLatin.Employees
SET FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, Email = @Email, SinNumber = @SinNumber, EmployeeAddress = @EmployeeAddress, BirthDate = @BirthDate
WHERE EmployeeId = @EmployeeId;
GO

CREATE PROCEDURE DDRestaurantLatin.EmployeesDelete @EmployeeId int 
AS
DELETE FROM DDRestaurantLatin.Employees
WHERE EmployeeId = @EmployeeId;
GO