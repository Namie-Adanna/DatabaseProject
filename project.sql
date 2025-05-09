-- Departments
CREATE TABLE departments (
    deptId INT PRIMARY KEY AUTO_INCREMENT,
    deptName VARCHAR(100) NOT NULL UNIQUE
);

-- Programs
CREATE TABLE programs (
    programId INT PRIMARY KEY AUTO_INCREMENT,
    programName VARCHAR(100) NOT NULL UNIQUE,
    degreeLevel ENUM('Associate', 'Bachelor', 'Master', 'PhD') NOT NULL,
    deptId INT,
    FOREIGN KEY (deptId) REFERENCES departments(deptId)
);

-- Instructors
CREATE TABLE instructors (
    instructorId INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    deptId INT,
    FOREIGN KEY (deptId) REFERENCES departments(deptId)
);

-- Courses
CREATE TABLE courses (
    courseId INT PRIMARY KEY AUTO_INCREMENT,
    courseCode VARCHAR(10) NOT NULL UNIQUE,
    courseName VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    deptId INT,
    FOREIGN KEY (deptId) REFERENCES departments(deptId)
);

-- Semesters
CREATE TABLE semesters (
    semesterId INT PRIMARY KEY AUTO_INCREMENT,
    semesterName VARCHAR(20) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL
);

-- Classrooms
CREATE TABLE classrooms (
    roomId INT PRIMARY KEY AUTO_INCREMENT,
    building VARCHAR(50) NOT NULL,
    roomNumber VARCHAR(10) NOT NULL,
    capacity INT NOT NULL
);

-- Schedule
CREATE TABLE schedule (
    scheduleId INT PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    instructorId INT NOT NULL,
    semesterId INT NOT NULL,
    roomId INT,
    dayOfWeek ENUM('Mon', 'Tue', 'Wed', 'Thu', 'Fri') NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(courseId),
    FOREIGN KEY (instructorId) REFERENCES instructors(instructorId),
    FOREIGN KEY (semesterId) REFERENCES semesters(semesterId),
    FOREIGN KEY (roomId) REFERENCES classrooms(roomId)
);

-- Students
CREATE TABLE students (
    studentId INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollmentDate DATE NOT NULL,
    programId INT,
    FOREIGN KEY (programId) REFERENCES programs(programId)
);

-- Student Contact
CREATE TABLE studentContact (
    contactId INT PRIMARY KEY AUTO_INCREMENT,
    studentId INT UNIQUE,
    phoneNumber VARCHAR(15),
    address TEXT,
    emergencyContactName VARCHAR(100),
    emergencyContactPhone VARCHAR(15),
    FOREIGN KEY (studentId) REFERENCES students(studentId)
);

-- Enrollments
CREATE TABLE enrollments (
    enrollmentId INT PRIMARY KEY AUTO_INCREMENT,
    studentId INT NOT NULL,
    scheduleId INT NOT NULL,
    enrollmentDate DATE NOT NULL,
    UNIQUE(studentId, scheduleId),
    FOREIGN KEY (studentId) REFERENCES students(studentId),
    FOREIGN KEY (scheduleId) REFERENCES schedule(scheduleId)
);

-- Grades
CREATE TABLE grades (
    gradeId INT PRIMARY KEY AUTO_INCREMENT,
    enrollmentId INT UNIQUE,
    grade CHAR(2) CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'I')),
    FOREIGN KEY (enrollmentId) REFERENCES enrollments(enrollmentId)
);

-- Admins
CREATE TABLE admins (
    adminId INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fullName VARCHAR(100) NOT NULL,
    role ENUM('Registrar', 'Academic Advisor', 'Super Admin') NOT NULL
);