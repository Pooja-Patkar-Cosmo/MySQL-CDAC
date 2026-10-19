
-- _____________________________________________________________________________
-- DATABASE ASSIGNMENT 4
-- _____________________________________________________________________________
CREATE DATABASE labjoins;
use labjoins;


-- 1. Write Create a Employee ,Department & Project Tables .Add atleast 5 records in each table & Write a following Queries.
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50) NOT NULL,
    budget DECIMAL(12, 2) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    dept_id INT,
    project_id INT,
    manager_id INT,
    city VARCHAR(50),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments (dept_id),
    CONSTRAINT fk_emp_proj FOREIGN KEY (project_id) REFERENCES projects (project_id),
    CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees (emp_id)
);

SELECT * FROM departments;
SELECT * FROM projects;
SELECT * FROM employees;

-- INSERTION OF RECORDS ---------------------------------------------------
INSERT INTO departments (dept_id, dept_name, location) VALUES
(101, 'IT', 'Mumbai'),
(102, 'Human Resources', 'Mumbai'),
(103, 'Marketing', 'Pune'),
(104, 'Finance', 'Pune'),
(105, 'Data Analytics', 'Mumbai'),
(106, 'Sales', 'Navi Mumbai');

INSERT INTO projects (project_id, project_name, budget) VALUES
(501, 'Cloud Infrastructure', 500000.00),
(502, 'Database Migration', 180000.00),
(503, 'HR Portal Upgrade', 120000.00),
(504, 'Digital Marketing Q4', 90000.00),
(505, 'Sales Expansion Hub', 250000.00);

UPDATE projects
SET budget = 180000.00
WHERE project_id = 504;

INSERT INTO employees (emp_id, first_name, last_name, salary, dept_id, project_id, manager_id, city) VALUES
(1001, 'Pooja', 'Patkar', 125000.00, 101, 501, NULL, 'Mumbai'),
(1002, 'Rahul', 'Sharma', 85000.00, 101, 501, NULL, 'Mumbai'),
(1003, 'Tina', 'Iyer', 62000.00, 101, 501, 1002, 'Mumbai'),
(1004, 'John', 'Miller', 58000.00, 101, 502, 1002, 'Pune'),
(1005, 'Daisy', 'Taylor', 54000.00, 101, 502, 1002, 'Mumbai'),
(1006, 'William', 'Davies', 51000.00, 101, 503, 1003, 'Pune'),
(1007, 'Rosie', 'Evans', 53000.00, 101, 503, 1003, 'Pune'),
(1008, 'George', 'Wilson', 49000.00, 102, 504, 1002, 'Mumbai'),
(1009, 'Sam', 'Taylor', 40000.00, 105, 504, 1008, 'Mumbai'),
(1010, 'Alex', 'Cooper', 36000.00, 105, 502, 1004, 'Pune'),
(1011, 'Violet', 'Clark', 22000.00, 106, 504, 1003, 'Mumbai'),
(1012, 'Kate', 'Bennett', 22000.00, 106, 505, 1005, 'Mumbai');

INSERT INTO employees (emp_id, first_name, last_name, salary, dept_id, project_id, manager_id, city) VALUES
(1013, 'River', 'Scott', 22000.00, NULL, NULL, 1005, 'Mumbai');
-- 2. Write a Relational Algebra expression to perform Cartesian Product (Cross Join) between Emp and Dept tables.
SELECT e.first_name, d.dept_id, d.dept_name 
FROM employees e
CROSS JOIN departments d;

-- 3. Write a SQL query to perform an INNER JOIN between Emp and Dept tables displaying EmpName and DeptName.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS emp_name, d.dept_name
FROM employees e 
INNER JOIN departments d 
ON e.dept_id = d.dept_id;

-- 4. Write a SQL query to perform a LEFT OUTER JOIN between Emp and Dept tables to display all employees along with their department information, including employees without a department.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS emp_name, d.dept_id, d.dept_name
FROM employees e 
LEFT OUTER JOIN departments d
ON e.dept_id = d.dept_id;

-- 5. Write a SQL query to perform a RIGHT OUTER JOIN between Emp and Dept tables.
SELECT d.dept_id, d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS emp_name
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.dept_id = d.dept_id;

-- 6. Write a SQL query to perform a NATURAL JOIN between Emp and Dept.
SELECT * 
FROM employees 
NATURAL JOIN departments;

-- 7. Write a SQL query to perform a CROSS JOIN between Emp and Project table.
SELECT e.emp_id, CONCAT(e.first_name, ' ', e.last_name) AS emp_name, p.project_id, p.project_name 
FROM employees e
CROSS JOIN projects p;

-- 8. Write a SQL query to create a new table EmpBackup with the same structure as Emp but no data.
CREATE TABLE emp_backup LIKE employees;
desc emp_backup;
select * from emp_backup;

-- 9. Write a SQL query to copy all data from Emp into EmpBackup table.
INSERT INTO emp_backup 
SELECT * FROM employees;

-- 10. Write a SQL query to create a new table ProjectArchive with the same structure and data as Project.
CREATE TABLE project_archive AS
SELECT * FROM projects;

select * from project_archive;


-- 11. Write a SQL query to create an AUTO_INCREMENT sequence for EmpID in the Emp table during table creation.
-- NOT EXECUTED ****************************8
CREATE TABLE employees_auto (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    dept_id INT,
    project_id INT,
    CONSTRAINT fk_auto_dept FOREIGN KEY (dept_id) REFERENCES departments (dept_id),
    CONSTRAINT fk_auto_proj FOREIGN KEY (project_id) REFERENCES projects (project_id)
);

-- 12. Write a SQL query using a subquery to find all employees whose salary is greater than the average salary of all employees.
SELECT emp_id, first_name, last_name, salary
FROM employees
WHERE salary> (
	SELECT AVG(salary) FROM employees
    );

-- 13. Write a SQL query using a subquery in WHERE clause to find employees working in departments located in 'Mumbai'.
SELECT * 
FROM employees 
WHERE dept_id IN (
    SELECT dept_id 
    FROM departments 
    WHERE location = 'Mumbai'
);

-- 14. Write a SQL query to display all departments where the number of employees is greater than 5, using a subquery.
SELECT dept_id, dept_name 
FROM departments 
WHERE dept_id IN (
    SELECT dept_id 
    FROM employees 
    GROUP BY dept_id 
    HAVING COUNT(emp_id) > 5
);

-- 15. Write a subqueries for find out Max salary of employee.
SELECT * FROM employees 
WHERE salary = ( 
	SELECT MAX(salary) FROM employees
);

-- 16. Write a self join query for each table.
-- Table A: Employees Self Join (Employee with their Manager)[cite: 10]
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- Table B: Departments Self Join (Pairing distinct departments that share the same location)[cite: 10]
SELECT 
    d1.dept_name AS department_1, 
    d2.dept_name AS department_2, 
    d1.location
FROM departments d1
JOIN departments d2 ON d1.location = d2.location AND d1.dept_id < d2.dept_id;

-- Table C: Projects Self Join (Pairing distinct projects that have the same budget)[cite: 10]
SELECT 
    p1.project_name AS project_1, 
    p2.project_name AS project_2, 
    p1.budget
FROM projects p1
JOIN projects p2 ON p1.budget = p2.budget AND p1.project_id < p2.project_id;





