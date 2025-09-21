--WHOLE CODE COPIED FROM CHATGPT BECAUSE I DONT KNOW WHAT IS A DDL SCRIPT


-- ===============================
--  HEALTHCARE APPOINTMENT SCHEMA
--  Compatible with MS SQL Server
-- ===============================

-- Drop tables if they already exist (for re-runs)
IF OBJECT_ID('dbo.Appointments', 'U') IS NOT NULL DROP TABLE dbo.Appointments;
IF OBJECT_ID('dbo.Patients', 'U') IS NOT NULL DROP TABLE dbo.Patients;
IF OBJECT_ID('dbo.Doctors', 'U') IS NOT NULL DROP TABLE dbo.Doctors;
IF OBJECT_ID('dbo.Hospitals', 'U') IS NOT NULL DROP TABLE dbo.Hospitals;
GO

-- ================
-- Patients Table
-- ================
CREATE TABLE Patients (
    PatientID BIGINT NOT NULL PRIMARY KEY,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M','F')),
    Age INT NOT NULL CHECK (Age >= 0),
    AgeGroup VARCHAR(20) NOT NULL CHECK (AgeGroup IN ('Child','Adult','Senior')),
    Neighbourhood NVARCHAR(100) NOT NULL,
    Scholarship BIT NOT NULL,
    Hipertension BIT NOT NULL,
    Diabetes BIT NOT NULL,
    Alcoholism BIT NOT NULL,
    Handcap INT NOT NULL CHECK (Handcap BETWEEN 0 AND 4)
);
GO

-- ================
-- Doctors Table
-- ================
CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    DoctorName NVARCHAR(100) NOT NULL,
    Specialty NVARCHAR(50) NOT NULL
);
GO

-- ================
-- Hospitals Table
-- ================
CREATE TABLE Hospitals (
    HospitalID INT IDENTITY(1,1) PRIMARY KEY,
    HospitalName NVARCHAR(100) NOT NULL
);
GO

-- =================
-- Appointments Table
-- =================
CREATE TABLE Appointments (
    AppointmentID BIGINT NOT NULL PRIMARY KEY,
    PatientID BIGINT NOT NULL,
    DoctorID INT NOT NULL,
    HospitalID INT NOT NULL,
    ScheduledDay DATETIME NOT NULL,
    AppointmentDay DATETIME NOT NULL,
    SMS_Received BIT NOT NULL,
    No_Show BIT NOT NULL,

    CONSTRAINT FK_Appointments_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    CONSTRAINT FK_Appointments_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
    CONSTRAINT CHK_ScheduleDate CHECK (ScheduledDay <= AppointmentDay)
);
GO

-- ====================
-- Helpful Performance Indexes
-- ====================
CREATE INDEX IX_Appointments_PatientID ON Appointments (PatientID);
CREATE INDEX IX_Appointments_DoctorID ON Appointments (DoctorID);
CREATE INDEX IX_Appointments_Hospital_Date ON Appointments (HospitalID, AppointmentDay);
CREATE INDEX IX_Appointments_NoShow ON Appointments (No_Show);
GO
