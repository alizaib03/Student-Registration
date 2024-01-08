DROP TABLE Students cascade constraints;
DROP TABLE Enrollments cascade constraints;
DROP TABLE Courses cascade constraints;
DROP TABLE Programs cascade constraints;
DROP TABLE Sections cascade constraints; 
DROP TABLE Class_Schedule cascade constraints;
DROP TABLE Classrooms cascade constraints;
DROP TABLE Faculty cascade constraints;
DROP TABLE Contracts cascade constraints;
DROP TABLE Departments cascade constraints;

DROP SEQUENCE Students_Seq;
DROP SEQUENCE Enrollments_Seq;
DROP SEQUENCE Courses_Seq;
DROP SEQUENCE Programs_Seq;
DROP SEQUENCE Sections_Seq;
DROP SEQUENCE Class_Schedule_Seq;
DROP SEQUENCE Classrooms_Seq;
DROP SEQUENCE Faculty_Seq;
DROP SEQUENCE Contracts_Seq;
DROP SEQUENCE Departments_Seq;

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FirstName VARCHAR (35) NOT NULL, 
LastName VARCHAR (35) NOT NULL,
DateOfBirth DATE NOT NULL,
Email VARCHAR (45),
ProgramID INT);

CREATE TABLE Programs (
ProgramID INT PRIMARY KEY,
ProgramName VARCHAR (50) NOT NULL,
ProgramType VARCHAR(50) NOT NULL,
DepartmentID INT);

CREATE TABLE Faculty (
FacultyID INT PRIMARY KEY,
FirstName VARCHAR (50) NOT NULL,
LastName VARCHAR (50) NOT NULL, 
Email VARCHAR (50)NOT NULL);

CREATE TABLE Sections (
SectionID INT PRIMARY KEY,
SectionNumber VARCHAR (50) NOT NULL,
Semester VARCHAR (50) NOT NULL,
CourseID INT,
FacultyID INT);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
EnrollmentDate DATE NOT NULL,
StudentID INT,
CourseID INT);

CREATE TABLE COURSES (
CourseID INT PRIMARY KEY,
Title VARCHAR (50) NOT NULL,
Credits VARCHAR (50) NOT NULL,
CourseCode VARCHAR(50) NOT NULL,
ProgramID INT);

CREATE TABLE Class_Schedule (
ScheduleID INT PRIMARY KEY,
ScheduleDate DATE NOT NULL,
StartTime VARCHAR (20) NOT NULL,
EndTime VARCHAR (20) NOT NULL,
SectionID INT,
ClassroomID INT);

CREATE TABLE Classrooms (
ClassroomID INT PRIMARY KEY,
RoomNumber VARCHAR (50) NOT NULL,
BuildingNumber VARCHAR (50) NOT NULL,
ClassCapacity INT NOT NULL);

CREATE TABLE Contracts (
ContractID INT PRIMARY KEY,
FacultyID INT,
DepartmentID INT);

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR (50) NOT NULL,
Campus VARCHAR (50) NOT NULL);

----------------------------------------------------------------------------------------------------------------
-- (THIS FOR STUDENTS ALTER TABLE, NEED TO GET IT TO WORK) ADD CONSTRAINT dob_Check CHECK (MONTHS BETWEEN(DATE, DateOfBirth) / 12 >= 18)

ALTER TABLE Students
ADD CONSTRAINT fk_Students_Programs FOREIGN KEY (ProgramID) References Programs (ProgramID)
ON DELETE CASCADE;

ALTER TABLE Programs
ADD CONSTRAINT fk_Programs_Departments FOREIGN KEY (DepartmentID) References Departments (DepartmentID)
ON DELETE CASCADE;

ALTER TABLE Sections
ADD CONSTRAINT fk_Sections_Courses FOREIGN KEY (CourseID) REFERENCES Courses (CourseID)
ADD CONSTRAINT fk_Sections_Faculty FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
ON DELETE CASCADE;

ALTER TABLE Enrollments
ADD CONSTRAINT fk_Enrollments_Students FOREIGN KEY (StudentID) REFERENCES Students (StudentID)
ADD CONSTRAINT fk_Enrollments_Courses FOREIGN KEY (CourseID) REFERENCES Courses (CourseID)
ON DELETE CASCADE;

ALTER TABLE Courses
ADD CONSTRAINT fk_Courses_Programs FOREIGN KEY (ProgramID) REFERENCES Programs (ProgramID)
ON DELETE CASCADE;

ALTER TABLE Class_Schedule
ADD CONSTRAINT fk_Class_Schedule_Sections FOREIGN KEY (SectionID) REFERENCES Sections (SectionID)
ADD CONSTRAINT fk_Class_Schedule_Classrooms FOREIGN KEY (ClassroomID) REFERENCES Classrooms (ClassroomID)
ON DELETE CASCADE;

ALTER TABLE Contracts
ADD CONSTRAINT fk_Contracts_Faculty FOREIGN KEY (FacultyID) REFERENCES Faculty (FacultyID)
ADD CONSTRAINT fk_Contracts_Departments FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID)
ON DELETE CASCADE;

----------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE Students_Seq
START WITH 100
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Enrollments_Seq
START WITH 200
INCREMENT BY 1
NOCACHE 
NOCYCLE;

CREATE SEQUENCE Courses_Seq
START WITH 300
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Programs_Seq
START WITH 400
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Sections_Seq
START WITH 500
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Class_Schedule_Seq
START WITH 600
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Classrooms_Seq
START WITH 700
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Faculty_Seq
START WITH 800
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Contracts_Seq
START WITH 900
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE SEQUENCE Departments_Seq
START WITH 1000
INCREMENT BY 1
NOCACHE
NOCYCLE;

----------------------------------------------------------------------------------------------------------------
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) 
VALUES (students_seq.NEXTVAL, 'Rizwan', 'Chohan', TO_DATE('2001-01-01', 'YYYY-MM-DD'), 'Rizwan.Chohan@email.com');

INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) 
VALUES (Students_Seq.NextVal, 'Helen', 'Zhou', TO_DATE('2000-02-01', 'YYYY-MM-DD'), 'Helen.Zhao@email.com');

INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) 
VALUES (Students_Seq.NextVal, 'Ali', 'Zaib', TO_DATE('2002-03-01', 'YYYY-MM-DD'), 'Ali.Zaib@email.com');

INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) 
VALUES (Students_Seq.NextVal, 'Spider', 'Man', TO_DATE('2002-04-01', 'YYYY-MM-DD'), 'Spider.Man@email.com');

INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, Email) 
VALUES (Students_Seq.NextVal, 'Sponge', 'Bob', TO_DATE('2003-05-01', 'YYYY-MM-DD'), 'Sponge.Bob@email.com');
-------------------------------------------------------------------------------------------------------------
INSERT INTO Programs (ProgramID, ProgramName, ProgramType)
VALUES (programs_seq.NEXTVAL, 'Information Technology', 'Degree');

INSERT INTO Programs (ProgramID, ProgramName, ProgramType)
VALUES (programs_seq.NEXTVAL, 'Engineering', 'Diploma');

INSERT INTO Programs (ProgramID, ProgramName, ProgramType)
VALUES (programs_seq.NEXTVAL, 'Business Administrations', 'Diploma');

INSERT INTO Programs (ProgramID, ProgramName, ProgramType)
VALUES (programs_seq.NEXTVAL, 'Hospitality Management', 'Diploma');

INSERT INTO Programs (ProgramID, ProgramName, ProgramType)
VALUES (programs_seq.NEXTVAL, 'Communications', 'Diploma');

-------------------------------------------------------------------------------------------------------------
INSERT INTO Faculty (FacultyID, FirstName, LastName, Email) 
VALUES (faculty_seq.NEXTVAL, 'Elmer', 'Fudd', 'Elmer.Fudd@email.com');

INSERT INTO Faculty (FacultyID, FirstName, LastName, Email) 
VALUES (faculty_seq.NEXTVAL, 'Pepe', 'LePew', 'Pepe.LePew@email.com');

INSERT INTO Faculty (FacultyID, FirstName, LastName, Email) 
VALUES (faculty_seq.NEXTVAL, 'Bugs', 'Bunny', 'Bugs.Bunny@email.com');

INSERT INTO Faculty (FacultyID, FirstName, LastName, Email) 
VALUES (faculty_seq.NEXTVAL, 'Lola', 'Bunny', 'Lola.Bunny@email.com');

INSERT INTO Faculty (FacultyID, FirstName, LastName, Email) 
VALUES (faculty_seq.NEXTVAL, 'Daffy', 'Duck', 'Daffy.Duck@email.com');
-------------------------------------------------------------------------------------------------------------
INSERT INTO Sections (SectionID, SectionNumber, Semester) 
VALUES (sections_seq.NEXTVAL, '001', 'Fall 2023');

INSERT INTO Sections (SectionID, SectionNumber, Semester) 
VALUES (sections_seq.NEXTVAL, '002', 'Fall 2023');

INSERT INTO Sections (SectionID, SectionNumber, Semester) 
VALUES (sections_seq.NEXTVAL, '003', 'Fall 2023');

INSERT INTO Sections (SectionID, SectionNumber, Semester) 
VALUES (sections_seq.NEXTVAL, '004', 'Fall 2023');

INSERT INTO Sections (SectionID, SectionNumber, Semester) 
VALUES (sections_seq.NEXTVAL, '005', 'Fall 2023');
-------------------------------------------------------------------------------------------------------------
INSERT INTO Enrollments (EnrollmentID, EnrollmentDate) 
VALUES (enrollments_seq.NEXTVAL, SYSDATE);

INSERT INTO Enrollments (EnrollmentID, EnrollmentDate) 
VALUES (enrollments_seq.NEXTVAL, SYSDATE);

INSERT INTO Enrollments (EnrollmentID, EnrollmentDate) 
VALUES (enrollments_seq.NEXTVAL, SYSDATE);

INSERT INTO Enrollments (EnrollmentID, EnrollmentDate) 
VALUES (enrollments_seq.NEXTVAL, SYSDATE);

INSERT INTO Enrollments (EnrollmentID, EnrollmentDate) 
VALUES (enrollments_seq.NEXTVAL, SYSDATE);
-------------------------------------------------------------------------------------------------------------
INSERT INTO Courses (CourseID,CourseCode, Title, Credits) 
VALUES (courses_seq.NEXTVAL, 'PROG101', 'Introduction to Programming', '4');

INSERT INTO Courses (CourseID,CourseCode, Title, Credits) 
VALUES (courses_seq.NEXTVAL, 'DBMS101', 'Introduction to SQL', '4');

INSERT INTO Courses (CourseID,CourseCode, Title, Credits) 
VALUES (courses_seq.NEXTVAL, 'MTH101', 'Applied Mathematics', '4');

INSERT INTO Courses (CourseID,CourseCode, Title, Credits) 
VALUES (courses_seq.NEXTVAL, 'ECON101', 'Micro Economics', '3');

INSERT INTO Courses (CourseID,CourseCode, Title, Credits) 
VALUES (courses_seq.NEXTVAL, 'BUS101', 'Business Principles', '4');

-------------------------------------------------------------------------------------------------------------
INSERT INTO Class_Schedule (ScheduleID, ScheduleDate, StartTime, EndTime)
VALUES (class_schedule_seq.NEXTVAL, TO_DATE('2023-09-06', 'YYYY-MM-DD'), '08:00', '10:00');

INSERT INTO Class_Schedule (ScheduleID, ScheduleDate, StartTime, EndTime)
VALUES (class_schedule_seq.NEXTVAL, TO_DATE('2023-09-06', 'YYYY-MM-DD'), '12:00', '2:00');

INSERT INTO Class_Schedule (ScheduleID, ScheduleDate, StartTime, EndTime)
VALUES (class_schedule_seq.NEXTVAL, TO_DATE('2023-09-06', 'YYYY-MM-DD'), '10:00', '12:00');

INSERT INTO Class_Schedule (ScheduleID, ScheduleDate, StartTime, EndTime)
VALUES (class_schedule_seq.NEXTVAL, TO_DATE('2023-09-06', 'YYYY-MM-DD'), '2:00', '4:00');

INSERT INTO Class_Schedule (ScheduleID, ScheduleDate, StartTime, EndTime)
VALUES (class_schedule_seq.NEXTVAL, TO_DATE('2023-09-06', 'YYYY-MM-DD'), '10:30', '12:30');
-------------------------------------------------------------------------------------------------------------
INSERT INTO Classrooms (ClassroomID, RoomNumber, BuildingNumber, ClassCapacity) 
VALUES (classrooms_seq.NEXTVAL, 'A21', 'B1', '30');

INSERT INTO Classrooms (ClassroomID, RoomNumber, BuildingNumber, ClassCapacity) 
VALUES (classrooms_seq.NEXTVAL, 'B36', 'B2', '30');

INSERT INTO Classrooms (ClassroomID, RoomNumber, BuildingNumber, ClassCapacity) 
VALUES (classrooms_seq.NEXTVAL, 'C56', 'B3', '30');

INSERT INTO Classrooms (ClassroomID, RoomNumber, BuildingNumber, ClassCapacity) 
VALUES (classrooms_seq.NEXTVAL, 'B12', 'B4', '30');

INSERT INTO Classrooms (ClassroomID, RoomNumber, BuildingNumber, ClassCapacity) 
VALUES (classrooms_seq.NEXTVAL, 'L2', 'B5', '30');
-------------------------------------------------------------------------------------------------------------
INSERT INTO Departments (DepartmentID, DepartmentName, Campus) 
VALUES (departments_seq.NEXTVAL, 'Engineering', 'Main Campus');

INSERT INTO Departments (DepartmentID, DepartmentName, Campus) 
VALUES (departments_seq.NEXTVAL, 'Business', 'Main Campus');

INSERT INTO Departments (DepartmentID, DepartmentName, Campus) 
VALUES (departments_seq.NEXTVAL, 'Hospitality', 'Main Campus');

INSERT INTO Departments (DepartmentID, DepartmentName, Campus) 
VALUES (departments_seq.NEXTVAL, 'Communications', 'Main Campus');

INSERT INTO Departments (DepartmentID, DepartmentName, Campus) 
VALUES (departments_seq.NEXTVAL, 'Film '|| '&'|| ' Media Studies', 'Main Campus');
---------------------------------------------------------------------------------------------------------------
INSERT INTO Contracts (ContractID, FacultyID, DepartmentID)
VALUES (Contracts_Seq.NEXTVAL, Faculty_seq.CURRVAL, Departments_Seq.CURRVAL);

INSERT INTO Contracts (ContractID, FacultyID, DepartmentID)
VALUES (Contracts_Seq.NEXTVAL, Faculty_seq.CURRVAL, Departments_Seq.CURRVAL);

INSERT INTO Contracts (ContractID, FacultyID, DepartmentID)
VALUES (Contracts_Seq.NEXTVAL, Faculty_seq.CURRVAL, Departments_Seq.CURRVAL);

INSERT INTO Contracts (ContractID, FacultyID, DepartmentID)
VALUES (Contracts_Seq.NEXTVAL, Faculty_seq.CURRVAL, Departments_Seq.CURRVAL);

INSERT INTO Contracts (ContractID, FacultyID, DepartmentID)
VALUES (Contracts_Seq.NEXTVAL, Faculty_seq.CURRVAL, Departments_Seq.CURRVAL);

----------------------------------------------------------------------------------------------------------------
COMMIT;












