-- 3 set operations

-- get sequence_name, last_number from user_sequences table and set table size.

SELECT sequence_name, last_number FROM user_sequences;
SET LINESIZE 150
SET PAGESIZE 50
COLUMN sequence_name FORMAT A30
COLUMN last_number FORMAT A15

-- update programid to students table.

UPDATE students SET programid = 400 WHERE studentid = 100;
UPDATE students SET programid = 401 WHERE studentid = 101;
UPDATE students SET programid = 402 WHERE studentid = 102;
UPDATE students SET programid = 403 WHERE studentid = 103;
UPDATE students SET programid = 404 WHERE studentid = 104;
SELECT * FROM students;

--update programid to courses table.

UPDATE courses SET programid = 400 WHERE courseid = 300;
UPDATE courses SET programid = 401 WHERE courseid = 301;
UPDATE courses SET programid = 402 WHERE courseid = 302;
UPDATE courses SET programid = 403 WHERE courseid = 303;
UPDATE courses SET programid = 404 WHERE courseid = 304;
SELECT * FROM courses;

--update departmentid to programs table.

UPDATE programs SET departmentid = 1000 WHERE programid = 400;
UPDATE programs SET departmentid = 1001 WHERE programid = 401;
UPDATE programs SET departmentid = 1002 WHERE programid = 402;
UPDATE programs SET departmentid = 1003 WHERE programid = 403;
UPDATE programs SET departmentid = 1004 WHERE programid = 404;
SELECT * FROM programs;

--update couseid and facultyid to sections table.

UPDATE sections SET courseid = 300, facultyid = 800 WHERE sectionid = 500;
UPDATE sections SET courseid = 301, facultyid = 801 WHERE sectionid = 501;
UPDATE sections SET courseid = 302, facultyid = 802 WHERE sectionid = 502;
UPDATE sections SET courseid = 303, facultyid = 803 WHERE sectionid = 503;
UPDATE sections SET courseid = 304, facultyid = 804 WHERE sectionid = 504;
SELECT * FROM sections;

--update to the enrollments table with a valid studentid and a valid courseid.

UPDATE enrollments SET courseid = 300, studentid = 100 WHERE enrollmentid = 200;
UPDATE enrollments SET courseid = 301, studentid = 101 WHERE enrollmentid = 201;
UPDATE enrollments SET courseid = 302, studentid = 102 WHERE enrollmentid = 202;
UPDATE enrollments SET courseid = 303, studentid = 103 WHERE enrollmentid = 203;
UPDATE enrollments SET courseid = 304, studentid = 104 WHERE enrollmentid = 204;
SELECT * FROM enrollments;

--update the contracts table.

UPDATE contracts SET facultyid = 800, departmentid = 1000 WHERE contractid = 900;
UPDATE contracts SET facultyid = 801, departmentid = 1001 WHERE contractid = 901;
UPDATE contracts SET facultyid = 802, departmentid = 1002 WHERE contractid = 902;
UPDATE contracts SET facultyid = 803, departmentid = 1003 WHERE contractid = 903;
UPDATE contracts SET facultyid = 804, departmentid = 1004 WHERE contractid = 904;
SELECT * FROM contracts;

--update the sectionid and classroomid to class_schedule table.

UPDATE class_schedule SET sectionid = 500, classroomid = 700 WHERE scheduleid = 600;
UPDATE class_schedule SET sectionid = 501, classroomid = 701 WHERE scheduleid = 601;
UPDATE class_schedule SET sectionid = 502, classroomid = 702 WHERE scheduleid = 602;
UPDATE class_schedule SET sectionid = 503, classroomid = 703 WHERE scheduleid = 603;
UPDATE class_schedule SET sectionid = 504, classroomid = 704 WHERE scheduleid = 604;
SELECT * FROM class_schedule;


-- 3 joins (with conditions)

--1. Retreive all students and program they are enrolled in?

SELECT s.StudentID, s.FirstName || ' ' || s.LastName name, p.ProgramName
FROM Students s JOIN Programs p ON s.ProgramID = p.ProgramID;

--2. Retreive all students and courses they are enrolled in.

SELECT s.StudentID, s.FirstName || ' ' || s.LastName studentname, c.title
FROM Students s JOIN Enrollments e ON s.StudentID=e.studentID
JOIN COURSES C ON e.courseid=c.courseid;

--3. Get all faculties contract with a specific department.

SELECT f.facultyid, f.FirstName || ' ' || f.LastName facultyname, d.departmentname 
FROM faculty f 
JOIN contracts co ON f.facultyid = co.facultyid
JOIN departments d ON d.departmentid = co.departmentid
WHERE d.departmentid = :departmentid;


-- 3 aggregate operations (must include joins)

--1. Get a course whereas enrollments are less than 2 students.

SELECT c.title, COUNT(e.enrollmentid) AS enrollment_count
FROM courses c
JOIN enrollments e ON c.courseid = e.courseid
GROUP BY c.title
HAVING COUNT(e.enrollmentid) < 2;

--2. get all courses for each faculty to teach.

SELECT f.facultyid, f.firstname || ' ' || f.lastname facultyname, 
        COUNT(c.courseid) AS numberOfCourses
FROM faculty f
JOIN sections se ON se.facultyid = f.facultyid
JOIN courses c ON c.courseid = se.courseid
GROUP BY f.facultyid, f.firstname, f.lastname;

--3. get all faculties work for each department.

SELECT departmentname, COUNT(co.facultyid) AS faculty_count
FROM departments d
JOIN contracts co ON co.departmentid = d.departmentid
JOIN faculty f ON f.facultyid = co.facultyid
GROUP BY departmentname;


-- 3 nested\sub-queries

--1. get courses which have equal to average students.

SELECT c.title, COUNT(e.enrollmentid) AS student_count
FROM courses c
JOIN enrollments e ON c.courseid = e.courseid
GROUP BY c.title
HAVING COUNT(e.enrollmentid) = (SELECT AVG(student_count) 
                                 FROM (SELECT COUNT(e.enrollmentid) AS student_count
                                       FROM courses c
                                       JOIN enrollments e ON c.courseid = e.courseid
                                       GROUP BY c.courseid));
                                       
--2. get faculties who have equal to average students 

SELECT f.firstname || ' ' || f.lastname facultyname, 
        COUNT(e.enrollmentid) AS student_count
FROM faculty f
JOIN sections se ON se.facultyid = f.facultyid
JOIN courses c ON c.courseid = se.courseid
JOIN enrollments e ON e.courseid = c.courseid
GROUP BY f.firstname, f.lastname
HAVING COUNT(e.enrollmentid) = (SELECT AVG(student_count)
                                FROM (SELECT COUNT(e.enrollmentid) AS student_count
                                      FROM faculty f
                                      JOIN sections se ON se.facultyid = f.facultyid
                                      JOIN courses c ON c.courseid = se.courseid
                                      JOIN enrollments e ON e.courseid = c.courseid
                                      GROUP BY f.facultyid, f.firstname, f.lastname));

--3. get a classroom which held in equal to average courses.

SELECT cl.roomnumber, COUNT(c.courseid) AS course_count
FROM classrooms cl
JOIN class_schedule cls ON cls.classroomid = cl.classroomid
JOIN sections se ON se.sectionid = cls.sectionid
JOIN courses c ON c.courseid = se.courseid
GROUP BY cl.classroomid, cl.roomnumber
HAVING COUNT(c.courseid) = (SELECT AVG(course_count)
                            FROM (SELECT COUNT(c.courseid) AS course_count
                                  FROM classrooms cl
                                  JOIN class_schedule cls ON cls.classroomid = cl.classroomid
                                  JOIN sections se ON se.sectionid = cls.sectionid
                                  JOIN courses c ON c.courseid = se.courseid
                                  GROUP BY cl.classroomid, cl.roomnumber));