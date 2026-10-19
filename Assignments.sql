-- LAB ___________________________________________________________________________________________________________________

CREATE DATABASE IF NOT EXISTS librarydb;
use librarydb;

-- _____________________________________________________________________________
-- DATABASE ASSIGNMENT 1: Schema Design & Table Creation (DDL & DML Commands)
-- _____________________________________________________________________________
-- 1. Define a schema for a Library Management System with the following entities: Books, Authors, Members, Borrow_Records
CREATE DATABASE IF NOT EXISTS librarydb;
use librarydb;

-- 2. Write the SQL command to create a table Authors with the following fields: 
-- author_id (Primary Key, INT), name (VARCHAR(100)), country (VARCHAR(50))
CREATE TABLE authors (
author_id INT PRIMARY KEY,
name VARCHAR(100),
country VARCHAR(50));

show tables;

-- 3. Write the SQL command to create a table Books with the following fields: 
-- book_id (Primary Key, INT), title (VARCHAR(150)), author_id (Foreign Key referencing Authors), published_year (YEAR), available_copies (INT)
CREATE TABLE books(
	book_id INT PRIMARY KEY,
	title VARCHAR(150),
    author_id INT,
	published_year YEAR,
	available_copies INT,
	CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


-- 4. Write the SQL command to create a table Members with: 
-- member_id (Primary Key, INT), name (VARCHAR(100)), email (VARCHAR(100), unique), phone (VARCHAR(15))
CREATE TABLE members(
	member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15));

-- 5. Write the SQL command to create a table Borrow_Records with: 
-- record_id (Primary Key, INT), member_id (Foreign Key referencing Members), book_id (Foreign Key referencing Books), borrow_date (DATE), return_date (DATE)
CREATE TABLE borrow_records(
	record_id INT PRIMARY KEY,
	member_id INT,
	book_id INT,
	borrow_date DATE,
	return_date DATE,
    
    CONSTRAINT fk_member FOREIGN KEY(member_id) REFERENCES members(member_id),
    CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES books(book_id)
    );

-- 6. Modify the Books table to add a column genre of type VARCHAR(50).
ALTER TABLE books 
ADD COLUMN genre VARCHAR(50);

-- 7. Write the SQL command to drop the Borrow_Records table -----------------------------------------
DROP TABLE IF EXISTS borrow_records;
show tables;
-- Recreating Borrow_Records --------------------------------------------
CREATE TABLE borrow_records(
	record_id INT PRIMARY KEY,
	member_id INT,
	book_id INT,
	borrow_date DATE,
	return_date DATE,
    
    CONSTRAINT fk_member FOREIGN KEY(member_id) REFERENCES members(member_id),
    CONSTRAINT fk_book FOREIGN KEY(book_id) REFERENCES books(book_id)
    );

-- 8. Insert 3 records into the Authors table -------------------------------------------------------
INSERT INTO authors(author_id, name, country) VALUES 
(1, 'John', 'USA'),
(2, 'Daisy', 'USA'),
(3, 'Kate', 'UK');



-- 9. Insert 5 books into the Books table.
INSERT INTO books(book_id, title, author_id, published_year, available_copies, genre) VALUES
(101, 'Database Systems', 1, 2018, 5, 'Education'),
(102, 'Operating Systems', 2, 2012, 3, 'Education'),
(103, 'Echoes of Eternity', 3, 2016, 5, 'Poetry'),
(104, 'Advanced SQL', 1, 2020, 4, 'Education'),
(105, 'The Silent Witness', 3, 2019, 3,'Thriller');


-- 10. Insert 3 members into the Members table.
INSERT INTO members (member_id, name, email, phone) VALUES 
(1001, 'Rosie', 'rosie@gmail.com', '9948043258'),
(1002, 'River', 'river@gmail.com', '8401202985'),
(1003, 'Sam', 'sam@gmail.com', '7904243982');

-- 11. Insert 4 borrow records into the Borrow_Records table.
INSERT INTO borrow_records(record_id, member_id, book_id, borrow_date, return_date) VALUES
(201, 1001, 101, '2026-01-10', '2026-01-20'),
(202, 1003, 102, '2026-02-05', '2026-02-15'),
(203, 1002, 105, '2026-09-01', NULL),
(204, 1001, 103, '2026-10-01', '2023-10-18');

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrow_records;
-- 12. Write an SQL query to select all books where published_year is after 2015.
SELECT * FROM books WHERE published_year > 2015;

-- 13. Write a SQL query to create a foreign key & primary key relationship between two tables.
-- Demonstrated via standalone DDL syntax
CREATE TABLE parent (parent_id INT PRIMARY KEY);
CREATE TABLE child (
	child_id INT PRIMARY KEY, 
    parent_id INT, 
    CONSTRAINT fk_parent FOREIGN KEY (parent_id) REFERENCES parent (parent_id));
    
-- SEQUENCE OF DROPPING THE TABLE WHEN FOREIGN KEY IS PRESENT ******************* 
DROP TABLE IF EXISTS child;
DROP TABLE IF EXISTS parent;

-- 14. Write an SQL query to find all members who have borrowed the book with title 'Database Systems'.
SELECT m.member_id, m.name, m.email, m.phone, br.record_id, b.book_id, b.title
FROM members m
JOIN borrow_records br ON m.member_id = br.member_id
JOIN books b ON br.book_id = b.book_id
WHERE b.title = 'Database Systems';


-- 15. Update the available_copies column of a specific book (choose any book) by reducing it by 1 after it is borrowed.
UPDATE books
SET available_copies = available_copies - 1    --   5 -> becomes 4
WHERE book_id = 103;

-- 16. Delete a record from Members where member_id = 1003.
-- Note: Removing dependent borrow records first to prevent foreign key constraint violations
DELETE FROM borrow_records WHERE member_id = 1003;
DELETE FROM members WHERE member_id = 1003;

-- 17. Update a Book name record from Book table with id = 1.
UPDATE books
SET title = 'Fundamentals of Database Systems' 
WHERE book_id = 101;

select * from books;
select * from authors;
-- 18. Write an SQL query to list all books along with their authors' names.
SELECT b.book_id, b.title, a.name as author_name
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- 19. Write an SQL query to delete all books from the Books table where the published_year is before 2000.
DELETE FROM borrow_records WHERE book_id IN ( SELECT book_id FROM books WHERE published_year < 2000);
DELETE FROM books WHERE published_year < 2000;
-- 20. Write an SQL query to find all books that are never borrowed (i.e., no records in Borrow_Records).

SELECT * FROM books WHERE book_id NOT IN ( SELECT DISTINCT book_id FROM borrow_records);

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

-- _____________________________________________________________________________
-- DATABASE ASSIGNMENT 3
-- _____________________________________________________________________________

-- 1. Write a query to calculate the total salary of all employees.
SELECT SUM(salary) AS Total_Salary FROM employees;

-- 2. Write a query to find the average salary of employees in each department using GROUP BY.
SELECT dept_id, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY dept_id;

-- 3. Write a query to count the total number of employees in each department.
SELECT dept_id, COUNT(emp_id) AS total_employees
FROM employees
GROUP BY dept_id;

-- 4. Write a query to display departments having more than 5 employees using HAVING clause.
-- M taking > 2 here
SELECT dept_id, COUNT(emp_id) AS emp_count
FROM employees
GROUP BY dept_id
HAVING COUNT(emp_id) > 2;

-- 5. Write a query to list distinct department locations from the Dept table.
SELECT DISTINCT city FROM employees;

-- 6. Write a query to display the highest salary among all employees. Write a query to display all total number of employee in table.
SELECT MAX(salary) AS highest_salary, COUNT(*) AS total_employees 
FROM employees;

-- 7. Write a query to find employees whose name starts with 'A' using LIKE operator. *******
SELECT * FROM employees WHERE emp_name LIKE 'T%'; 

-- 8. Write a query to find employees whose name ends with 'n' using LIKE operator.  *********
SELECT * 
FROM employees 
WHERE emp_name LIKE '%s';


-- 9. Write a query to find employees whose name contains 'ra' using LIKE operator.
SELECT * 
FROM employees 
WHERE emp_name LIKE '%ra%';

-- 10. Write a query to display all employees sorted by their Salary in descending order.
SELECT * 
FROM employees 
ORDER BY salary DESC;

-- 11. Write a query to display all employees sorted by DeptID ascending and then Salary descending.
SELECT * 
FROM employees 
ORDER BY dept_id ASC, salary DESC;

-- 12. Write a query to find employees whose salary is between 30,000 and 60,000.
SELECT * 
FROM employees 
WHERE salary BETWEEN 30000 AND 60000;

-- 13. Write a query to display all employees whose DeptID is in (10, 20, 30).
SELECT * 
FROM employees 
WHERE dept_id IN (101, 102, 103);

-- 14. Write a query to display Min salary of employee.
SELECT MIN(salary) AS min_salary 
FROM employees;

-- 15. Write a query to display employees whose JoiningDate is between '2020-01-01' and '2021-12-31'.
SELECT * 
FROM employees 
WHERE joining_date BETWEEN '2020-01-01' AND '2021-12-31';

-- 16. Write a query to display employees whose Salary is NULL.
SELECT * 
FROM employees 
WHERE salary IS NULL;

-- 17. Write a query to display employees whose Salary is NOT NULL.
SELECT * 
FROM employees 
WHERE salary IS NOT NULL;

-- 18. Write a query to calculate the total salary per department, but only for departments where total salary is greater than 1,00,000 (use HAVING).
SELECT dept_id, SUM(salary) AS total_department_salary
FROM employees 
GROUP BY dept_id
HAVING SUM(salary) > 100000.00;


-- 19. Write a query to display all distinct employee names.
SELECT DISTINCT emp_name FROM employees;

-- 20. Write a query to count the number of departments having the same location.
SELECT city, COUNT(DISTINCT dept_id) AS number_of_departments
FROM employees
GROUP BY city;

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




