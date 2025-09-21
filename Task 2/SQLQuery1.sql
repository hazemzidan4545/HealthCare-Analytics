CREATE DATABASE HealthCareDB2;


CREATE TABLE Patients (
    PatientID BIGINT PRIMARY KEY,
    Gender VARCHAR(5),
    Age INT,
    AgeGroup VARCHAR(20), 
    Neighbourhood NVARCHAR(100),
    Scholarship BIT, -- 1 = Yes, 0 = No
    Hipertension BIT,
    Diabetes BIT,
    Alcoholism BIT,
    Handcap INT
);
 

 CREATE TABLE Doctors (
    DoctorID BIGINT PRIMARY KEY,
    DoctorName NVARCHAR(100) NOT NULL,
    Specialty NVARCHAR(50) NOT NULL
);

CREATE TABLE Hospitals (
    HospitalID BIGINT PRIMARY KEY,
    HospitalName NVARCHAR(100) NOT NULL
);


CREATE TABLE Appointments (
    AppointmentID BIGINT PRIMARY KEY, -- from dataset
    PatientID BIGINT NOT NULL,
    DoctorID BIGINT NOT NULL,
    HospitalID BIGINT NOT NULL,
    ScheduledDay DATETIME NOT NULL,
    AppointmentDay DATETIME NOT NULL,
    SMS_Received BIT,
    No_Show BIT, -- 1 = No-Show, 0 = Attended

    CONSTRAINT FK_Appointments_Patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    CONSTRAINT FK_Appointments_Hospital FOREIGN KEY (HospitalID) REFERENCES Hospitals(HospitalID),
);

-- Index on Patient lookups
CREATE INDEX IX_Appointments_PatientID ON Appointments (PatientID);

-- Index on Doctor lookups
CREATE INDEX IX_Appointments_DoctorID ON Appointments (DoctorID);

-- Index on Hospital + AppointmentDay (for time-series queries)
CREATE INDEX IX_Appointments_Hospital_Date ON Appointments (HospitalID, AppointmentDay);

-- Index for filtering by No_Show
CREATE INDEX IX_Appointments_NoShow ON Appointments (No_Show);


CREATE NONCLUSTERED INDEX idx_appts_appoitday ON Appointments(AppointmentDay);
