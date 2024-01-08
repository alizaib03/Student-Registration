CREATE TABLE Students( 
  StudentID INT PRIMARY KEY NOT NULL,
  FirstName VARCHAR2(50),
  LastName VARCHAR2(50),
  Email VARCHAR2(100),
  ProgramID INT);
  
  ALTER TABLE Students
  ADD CONSTRAINT fk_Students_Programs FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID);

CREATE TABLE Faculty (
  FacultyID INT PRIMARY KEY NOT NULL,
  FirstName VARCHAR2(50),
  LastName VARCHAR2(50),
  Email VARCHAR2(100),
  ProgramID INT);
  
  ALTER TABLE Faculty
  ADD CONSTRAINT fk_Faculty_Programs FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID);

CREATE TABLE Enrollments (
  EnrollmentID INT PRIMARY KEY NOT NULL,
  StudentID INT,
  CourseID INT,
  EnrollmentDate DATE);
  
  ALTER TABLE Enrollments
  ADD CONSTRAINT fk_Enrollments_students FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
  ADD CONSTRAINT fk_Enrollments_Courses FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

drop table enrollments;
CREATE TABLE Courses (
  CourseID INT PRIMARY KEY NOT NULL,
  CourseName VARCHAR2(100),
  CourseCode VARCHAR2(10),
  Credits INT,
  ProgramID INT,
  ClassroomID INT);
  
  ALTER TABLE Courses 
  ADD CONSTRAINT fk_courses_Programs FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID)
  ADD CONSTRAINT fk_Courses_Classrooms FOREIGN KEY (ClassroomID) REFERENCES Classrooms(ClassroomID);

CREATE TABLE Classrooms (
  ClassroomID INT PRIMARY KEY NOT NULL,
  RoomNumber VARCHAR2(10),
  Building VARCHAR2(50),
  Capacity INT);

CREATE TABLE Programs (
  ProgramID INT PRIMARY KEY NOT NULL,
  ProgramName VARCHAR2(100),
  FacultyHeadID INT);
  
  ALTER TABLE Programs  
  ADD CONSTRAINT fk_Programs_Faculty FOREIGN KEY (FacultyHeadID) REFERENCES Faculty(FacultyID));

CREATE TABLE CourseAssignments (
  AssignmentID INT PRIMARY KEY NOT NULL,
  FacultyID INT,
  CourseID INT,
  Semester VARCHAR2(50),
  Year INT);
    
  ALTER TABLE CourseAssignments
  ADD CONSTRAINTS fk_CourseAssignments_Faculty FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
  ADD CONSTRAINT fk_CourseAssignments_Courses FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

select*from user_sequences;

CREATE SEQUENCE seq_student_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_faculty_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_enrollment_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_course_id START WITH 1 INCREMENT BY 3;
CREATE SEQUENCE seq_classroom_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_program_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_assignment_id START WITH 1 INCREMENT BY 1;

INSERT INTO Students (StudentID, FirstName, LastName, Email, programID) VALUES (seq_student_id.NEXTVAL, 'Rizwan', 'Chohan', 'Rizwan@example.com', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Email, programID) VALUES (seq_student_id.NEXTVAL, 'Helen', 'Zhao', 'Helen@example.com', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Email, programID) VALUES (seq_student_id.NEXTVAL, 'Ali', 'Zaib', 'Ali@example.com', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Email, programID) VALUES (seq_student_id.NEXTVAL, 'John', 'Wick', 'John@example.com', 1);
INSERT INTO Students (StudentID, FirstName, LastName, Email, programID) VALUES (seq_student_id.NEXTVAL, 'David', 'Blain', 'David@example.com', 1);

INSERT INTO Faculty (FacultyID, FirstName, LastName, Email, ProgramID) VALUES (seq_faculty_id.NEXTVAL, 'Daffy', 'Duck', 'Daffy@example.com', 1);
INSERT INTO Faculty (FacultyID, FirstName, LastName, Email, ProgramID) VALUES (seq_faculty_id.NEXTVAL, 'Mickey', 'Mouse', 'Mickey@example.com', 1);
INSERT INTO Faculty (FacultyID, FirstName, LastName, Email, ProgramID) VALUES (seq_faculty_id.NEXTVAL, 'Bart', 'Simpson', 'Bart@example.com', 1);
INSERT INTO Faculty (FacultyID, FirstName, LastName, Email, ProgramID) VALUES (seq_faculty_id.NEXTVAL, 'Bugs', 'Bunny', 'Bugs@example.com', 1);
INSERT INTO Faculty (FacultyID, FirstName, LastName, Email, ProgramID) VALUES (seq_faculty_id.NEXTVAL, 'Masha', 'Bear', 'Masha@example.com', 1);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (seq_enrollment_id.NEXTVAL, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (seq_enrollment_id.NEXTVAL, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (seq_enrollment_id.NEXTVAL, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (seq_enrollment_id.NEXTVAL, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES (seq_enrollment_id.NEXTVAL, 1, 1, TO_DATE('2023-09-01', 'YYYY-MM-DD'));

INSERT INTO Courses (CourseID, CourseName, CourseCode, Credits, ProgramID, ClassroomID) VALUES (seq_course_id.NEXTVAL, 'Introduction to DBMS', 'ORA101', 3, 1, 1);
INSERT INTO Courses (CourseID, CourseName, CourseCode, Credits, ProgramID, ClassroomID) VALUES (seq_course_id.NEXTVAL, 'Computer Systems', 'COM101', 3, 1, 1);
INSERT INTO Courses (CourseID, CourseName, CourseCode, Credits, ProgramID, ClassroomID) VALUES (seq_course_id.NEXTVAL, 'Introduction to Networking', 'NET101', 3, 1, 1);
INSERT INTO Courses (CourseID, CourseName, CourseCode, Credits, ProgramID, ClassroomID) VALUES (seq_course_id.NEXTVAL, 'Calculus', 'MTH101', 3, 1, 1);
INSERT INTO Courses (CourseID, CourseName, CourseCode, Credits, ProgramID, ClassroomID) VALUES (seq_course_id.NEXTVAL, 'Management Principles', 'BUS101', 3, 1, 1);

INSERT INTO Classrooms (ClassroomID, RoomNumber, Building, Capacity) VALUES (seq_classroom_id.NEXTVAL, '101', 'Building A', 30);
INSERT INTO Classrooms (ClassroomID, RoomNumber, Building, Capacity) VALUES (seq_classroom_id.NEXTVAL, '102', 'Building B', 30);
INSERT INTO Classrooms (ClassroomID, RoomNumber, Building, Capacity) VALUES (seq_classroom_id.NEXTVAL, '103', 'Building C', 30);
INSERT INTO Classrooms (ClassroomID, RoomNumber, Building, Capacity) VALUES (seq_classroom_id.NEXTVAL, '104', 'Building D', 30);
INSERT INTO Classrooms (ClassroomID, RoomNumber, Building, Capacity) VALUES (seq_classroom_id.NEXTVAL, '104', 'Building E', 30);

INSERT INTO Programs (ProgramID, ProgramName, FacultyHeadID) VALUES (seq_program_id.NEXTVAL, 'Computer Science', 1);
INSERT INTO Programs (ProgramID, ProgramName, FacultyHeadID) VALUES (seq_program_id.NEXTVAL, 'Business Admininstrations', 1);
INSERT INTO Programs (ProgramID, ProgramName, FacultyHeadID) VALUES (seq_program_id.NEXTVAL, 'Aerospace and Aviation', 1);
INSERT INTO Programs (ProgramID, ProgramName, FacultyHeadID) VALUES (seq_program_id.NEXTVAL, 'Food and Tourism', 1);
INSERT INTO Programs (ProgramID, ProgramName, FacultyHeadID) VALUES (seq_program_id.NEXTVAL, 'Systems Automation', 1);

INSERT INTO CourseAssignments (AssignmentID, FacultyID, CourseID, Semester, Year) VALUES (seq_assignment_id.NEXTVAL, 1, 101, 'Fall', 2023);
INSERT INTO CourseAssignments (AssignmentID, FacultyID, CourseID, Semester, Year) VALUES (seq_assignment_id.NEXTVAL, 1, 101, 'Fall', 2023);
INSERT INTO CourseAssignments (AssignmentID, FacultyID, CourseID, Semester, Year) VALUES (seq_assignment_id.NEXTVAL, 1, 101, 'Fall', 2023);
INSERT INTO CourseAssignments (AssignmentID, FacultyID, CourseID, Semester, Year) VALUES (seq_assignment_id.NEXTVAL, 1, 101, 'Fall', 2023);
INSERT INTO CourseAssignments (AssignmentID, FacultyID, CourseID, Semester, Year) VALUES (seq_assignment_id.NEXTVAL, 1, 101, 'Fall', 2023);


Commit;






