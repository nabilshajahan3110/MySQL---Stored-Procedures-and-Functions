# DAY 22 - Challenge 22

# STORED PROCEDURES AND FUNCTIONS

USE Challenge;

ALTER TABLE Persons
ADD DOB Date;

UPDATE Persons SET DOB = '1988-10-31' WHERE ID = 451;
UPDATE Persons SET DOB = '1990-08-28' WHERE ID = 452;
UPDATE Persons SET DOB = '1985-02-23' WHERE ID = 453;
UPDATE Persons SET DOB = '1986-03-09' WHERE ID = 454;
UPDATE Persons SET DOB = '1993-08-08' WHERE ID = 455;
UPDATE Persons SET DOB = '1982-11-13' WHERE ID = 456;
UPDATE Persons SET DOB = '1989-12-19' WHERE ID = 457;
UPDATE Persons SET DOB = '1982-05-11' WHERE ID = 458;
UPDATE Persons SET DOB = '1979-04-25' WHERE ID = 459;
UPDATE Persons SET DOB = '1996-07-07' WHERE ID = 460;
UPDATE Persons SET DOB = '1990-06-13' WHERE ID = 461;
UPDATE Persons SET DOB = '1977-01-30' WHERE ID = 462;

SELECT * FROM Persons;

# 1. Write a user-defined function to calculate age using DOB.

DELIMITER $$
CREATE FUNCTION AgeOfPerson(DOB DATE)
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (FLOOR(DATEDIFF(CURDATE(), DOB) / 365.25));
END $$
DELIMITER ;

# 2. Write a select query to fetch the Age of all persons using the function that has been created.

SELECT CONCAT(Fname," ",Lname) AS FullName, 
AgeOfPerson(DOB) AS Age
FROM Persons;

# STORED PROCEDURE

CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY AUTO_INCREMENT,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);

INSERT INTO Worker (FirstName, LastName, Salary, JoiningDate, Department)
VALUES
('John', 'Doe', 50000, '2020-01-15 09:00:00', 'HR'),
('Jane', 'Smith', 60000, '2019-03-22 09:00:00', 'Finance'),
('Michael', 'Johnson', 70000, '2018-06-10 09:00:00', 'IT'),
('Emily', 'Brown', 55000, '2021-08-30 09:00:00', 'Marketing'),
('David', 'Davis', 65000, '2017-11-12 09:00:00', 'Sales'),
('Emma', 'Wilson', 50000, '2020-09-25 09:00:00', 'HR'),
('James', 'Martinez', 80000, '2016-05-18 09:00:00', 'Finance'),
('Sophia', 'Garcia', 75000, '2019-02-07 09:00:00', 'IT'),
('Oliver', 'Anderson', 62000, '2022-01-20 09:00:00', 'Marketing'),
('Ava', 'Thomas', 72000, '2015-07-15 09:00:00', 'Sales'),
('Isabella', 'Lee', 67000, '2021-03-12 09:00:00', 'HR'),
('Mason', 'Harris', 58000, '2018-10-05 09:00:00', 'Finance'),
('Lucas', 'Clark', 54000, '2020-06-22 09:00:00', 'IT'),
('Mia', 'Lewis', 73000, '2019-09-11 09:00:00', 'Marketing'),
('Elijah', 'Walker', 68000, '2017-12-21 09:00:00', 'Sales');

SELECT * FROM Worker;

SET SQL_SAFE_UPDATES = 0;

/* 3. Write a stored procedure that takes in an IN parameter for DEPARTMENT 
and an OUT parameter for p_avgSalary. It should retrieve the average salary of all workers 
in the given department and returns it in the p_avgSalary parameter and call the procedure.*/

DELIMITER $$

CREATE PROCEDURE GetAverageSalaryByDepartment(
IN p_department VARCHAR(100),
OUT p_avgSalary DECIMAL(8,2)
)
BEGIN
SELECT AVG(Salary) INTO p_avgSalary
FROM Worker
WHERE Department = p_Department;
END $$

DELIMITER ;

SET @avgsalary = 0;
CALL GetAverageSalaryByDepartment('IT',@avgsalary);
SELECT @avgsalary AS DeptAvgSalary;