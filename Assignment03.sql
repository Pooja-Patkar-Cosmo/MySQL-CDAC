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

