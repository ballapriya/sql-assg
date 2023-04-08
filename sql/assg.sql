CREATE DATABASE MYSQL_ASSIGNMENT_1;
use MYSQL_Assignment_1;
---- creating EmployeeDetails table
CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(255) NOT NULL,
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(50)
);
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City) VALUES
(121, 'Hrushikesh Nayak', 321, '2019-01-31', 'Toronto'),
(321, 'Akankshya Nayak', 986, '2020-01-30', 'California'),
(421, 'Debashish Rout', 876, '2021-11-27', 'New Delhi');

---- creating EmployeeSalary table
CREATE TABLE EmployeeSalary (
  EmpId INT PRIMARY KEY,
  Project VARCHAR(255) NOT NULL,
  Salary DECIMAL(10,2),
  Variable DECIMAL(10,2)
);
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable) VALUES
(121, 'P1', 8000, 500),
(321, 'P2', 10000, 1000),
(421, 'P1', 12000, 0);
UPDATE EmployeeSalary
SET Salary = CASE EmpId 
               WHEN 121 THEN 80000
               WHEN 321 THEN 100000
               WHEN 421 THEN 120000
             END,
    Variable = CASE EmpId
                 WHEN 121 THEN 500
                 WHEN 321 THEN 1000
                 WHEN 421 THEN 0
               END
WHERE EmpId IN (121, 321, 421);
-- DISPLAYING TABLE VALUES
SELECT * FROM EmployeeDetails;
SELECT * FROM EmployeeSalary;

-- Q1-SQL Query to fetch records that are present in one table but not in another table.
-- ANS 1-
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;
-- Q2-SQL query to fetch all the employees who are not working on any project.
-- ANS 2-
SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.Project IS NULL;
-- Q3-SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.
-- ANS 3-
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;
-- Q4-Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.
-- ANS 4-
SELECT EmployeeDetails.*
FROM EmployeeDetails
INNER JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId;
-- Q5-Write an SQL query to fetch a project-wise count of employees.
-- ANS 5-
SELECT Project, COUNT(DISTINCT EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;
-- Q6-Fetch employee names and salaries even if the salary value is not present for the employee.
-- ANS 6-
SELECT ed.FullName, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;
-- Q7-Write an SQL query to fetch all the Employees who are also managers.
-- ANS 7-
SELECT ed.FullName
FROM EmployeeDetails ed
INNER JOIN EmployeeDetails em
ON ed.EmpId = em.ManagerId;
-- Q8-Write an SQL query to fetch duplicate records from EmployeeDetails.
-- ANS 8-
SELECT EmpId, COUNT(*) as DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId
HAVING COUNT(*) > 1;
-- Q9-Write an SQL query to fetch only odd rows from the table.
-- ANS 9-
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) as RowNum
  FROM EmployeeDetails
) t
WHERE t.RowNum % 2 = 1;
-- Q10-Write a query to find the 3rd highest salary from a table without top or limit keyword.
-- ANS 10-
SELECT DISTINCT Salary
FROM EmployeeSalary e1
WHERE 3 = (
    SELECT COUNT(DISTINCT Salary)
    FROM EmployeeSalary e2
    WHERE e2.Salary >= e1.Salary
);




















