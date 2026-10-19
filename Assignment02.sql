-- _____________________________________________________________________________
-- DATABASE ASSIGNMENT 2
-- _____________________________________________________________________________
CREATE DATABASE labdb;

use labdb;

-- 1. Write a SQL query to create Employee & Department table with specific columns and constraints.(Note- Create Table, insert data as per your Choice)
CREATE TABLE departments (
	dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50));
    
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    dept_id INT,
    joining_date DATE,

    CONSTRAINT fk_emp_dept FOREIGN KEY(dept_id) REFERENCES departments (dept_id)
);

show tables;
select * from employees;
select * from departments;

-- 2. Write a SQL query to add any new column to an existing table.
ALTER TABLE employees ADD COLUMN email VARCHAR(50);

-- 3. Write a SQL query to insert multiple records (At least 5) into a table in a single operation.
INSERT INTO departments (dept_id, dept_name) VALUES
(101, 'Engineering'),
(102, 'Sales'),
(103, 'Human Resources'),
(104, 'Operations'),
(105, 'Finance');

INSERT INTO employees (emp_id, emp_name, salary, dept_id, joining_date, email) VALUES
(1002, 'Rahul Sharma', 45000.00, 101, '2023-01-15', 'rahul.cdac@gmail.com'),
(1003, 'Tina Iyer', 55000.00, 102, '2022-06-10', 'tina.cdac@gmail.com'),
(1004, 'John Miller', 62000.00, 101, '2021-11-20', 'john.cdac@gmail.com'),
(1005, 'Daisy Taylor', 48000.00, 103, '2024-02-01', 'daisy.cdac@gmail.com'),
(1006, 'William Davies', 75000.00, 102, '2020-08-05', 'william.cdac@gmail.com');

-- 4. Write a SQL query to delete all records from a table.
-- NOT EXECUTED ******************************	
DELETE FROM employees;
    
-- 5. Write a SQL query to update salary records from a table where id = 5.
UPDATE employees
SET salary = 65000.00 
WHERE emp_id = 1005;

-- 6. Write a query to grant SELECT privilege on the Emp table to user readonly_user.
CREATE USER IF NOT EXISTS 'readonly_user'@'localhost' IDENTIFIED BY 'pass@01';
GRANT SELECT ON labdb.employees TO 'readonly_user'@'localhost';

DROP USER IF EXISTS 'readonly_user'@'localhost';

-- 7. Write a query to revoke INSERT privilege on the Emp table from user temp_user.
CREATE USER IF NOT EXISTS 'temp_user'@'%' IDENTIFIED BY 'pass@02';
GRANT INSERT ON labdb.employees TO 'temp_user'@'%';
REVOKE INSERT ON labdb.employees FROM 'temp_user'@'%';

DROP USER IF EXISTS 'temp_user'@'%';

-- 8. Write a query to insert a new employee into the Emp table and commit the transaction.
START TRANSACTION;
INSERT INTO employees (emp_id, emp_name, salary, dept_id, joining_date, email)
VALUES (1001, 'Rosie Evans', 52000.00, 101, '2024-03-01', 'rosie.cdac@gmail.com');
COMMIT; 
-- commit or rollback ends the transaction.

-- MySQL returns to autocommit mode - the default setting in MySQL Workbench. 
-- This delete command is executed as its own brand-new transaction and is committed instantly.
--                delete from employees where emp_id = 1001; 

-- 9. Write a query to update the Salary of an employee with EmpID = 101 and commit the transaction
START TRANSACTION;
UPDATE employees
SET salary = 85000 
WHERE emp_id = 1001;
COMMIT;

-- 10. Write a query to set a SAVEPOINT before updating the DeptID of an employee.
START TRANSACTION;
SAVEPOINT before_dept_update;
UPDATE employees
SET dept_id = 102 
WHERE emp_id = 1002;

select * from employees;
-- 11. Write a query to rollback to the previously created SAVEPOINT.
ROLLBACK TO SAVEPOINT before_dept_update;
COMMIT;

-- 12. Write a query to truncate all data from the Emp table.
-- Note: Foreign key checks are temporarily disabled if child tables enforce FK integrity during truncate operations
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE employees;
SET FOREIGN_KEY_CHECKS = 1;

-- 13. Write a query to list all employees whose salary is greater than 50,000.
SELECT * 
FROM employees 
WHERE salary > 50000.00;

-- 14. Write a query to increase the salary of all employees in DeptID = 10 by 10%.
UPDATE employees 
SET salary = salary * 1.10 
WHERE dept_id = 102;

-- 15. Write a query to count the total number of employees in each department.
SELECT d.dept_id, d.dept_name,
COUNT(e.emp_id) as total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 16. Write a query to list departments that have no employees. & create a view for those salespeople who belong to the city of Mumbai.
ALTER TABLE employees 
ADD COLUMN city VARCHAR(50);

UPDATE employees SET city = 'Mumbai' WHERE emp_id IN (1002, 1003, 1005, 1006);
UPDATE employees SET city = 'Pune' WHERE emp_id = 1004;
UPDATE employees SET city = 'Mumbai' WHERE emp_id = 1001;

select * from employees;

-- --------------------------------------------

SELECT d.dept_id, d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) = 0;

 -- OR ---------------------------------------

SELECT dept_id, dept_name
FROM departments 
WHERE dept_id NOT IN(
	SELECT dept_id FROM employees
    WHERE dept_id IS NOT NULL);
    
-- --------------------------------------------

-- 17. Write a query to display the highest salary among all employees.
SELECT MAX(salary) AS Highest_Salary FROM employees;

-- 18. Write a query to display the 2nd highest salary among all employees.
SELECT MAX(salary) AS second_highest_salary 
FROM employees 
WHERE salary < (SELECT MAX(salary) FROM employees);

-- 19. Write a query to show all employees ordered by JoiningDate in descending order.
SELECT * FROM employees ORDER BY joining_date DESC;

-- 20. Write a query to rename the DeptName column to DepartmentName.
ALTER TABLE departments
RENAME COLUMN dept_name TO department_name;


