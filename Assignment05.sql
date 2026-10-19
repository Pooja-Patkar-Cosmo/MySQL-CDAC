-- MYSQL STORED PROCEDURE ASSIGNMENT
-- _____________________________________________________________________________

-- Q1. Check Even or Odd: Create a stored procedure check_even_odd that accepts an integer and displays whether the number is Even or Odd. 
-- Test cases: CALL check_even_odd(25); CALL check_even_odd(40);
DELIMITER $$ 

DROP PROCEDURE IF EXISTS check_even_odd$$

CREATE PROCEDURE check_even_odd(IN num INT)
BEGIN
	IF num %2 = 0 THEN
		SELECT num as Number, 'Even' As Result;
	ELSE 
		SELECT num as Number, 'Odd' AS Result;
	END IF;
END$$

DELIMITER ;
CALL check_even_odd(25);
CALL check_even_odd(40);

-- Q2. Calculate Simple Interest: Create a stored procedure calculate_interest that accepts principal amount, rate of interest, and time in years and calculates Simple Interest.
-- Simple Interest = (Principal x Rate x Time) / 100. Test cases: CALL calculate_interest(10000, 5, 2); CALL calculate_interest(25000, 7, 3);
DELIMITER $$

DROP PROCEDURE IF EXISTS calculate_interest$$

CREATE PROCEDURE calculate_interest(
    IN p_principal DECIMAL(10,2), 
    IN p_rate DECIMAL(5,2), 
    IN p_time DECIMAL(5,2)
)
BEGIN
    DECLARE si DECIMAL(10,2);
    SET si = (p_principal * p_rate * p_time) / 100;
    
    SELECT p_principal AS Principal, 
           p_rate AS Rate, 
           p_time AS Time_Years, 
           si AS Simple_interest;
END$$

DELIMITER ;

CALL calculate_interest(10000,5,2);
CALL calculate_interest(25000,7,3);

-- Q3. Calculate Grade: Create a stored procedure calculate_grade that accepts student ID, student name, and marks and 
-- displays the student's grade (90-100: A+, 80-89: A, 70-79: B, 60-69: C, 50-59: D, Below 50: F). 
-- Test cases: CALL calculate_grade(101, 'Amit', 85); CALL calculate_grade(102, 'Priya', 72); CALL calculate_grade(103, 'Rahul', 45);
DELIMITER $$

DROP PROCEDURE IF EXISTS calculate_grade$$

CREATE PROCEDURE calculate_grade(IN student_id INT, IN student_name VARCHAR(50), IN marks INT)
BEGIN
	DECLARE grade VARCHAR(2);
	SET grade = CASE
		WHEN marks >= 90 AND marks <= 100 THEN 'A'
        WHEN marks >= 80 THEN 'A'
        WHEN marks >= 70 THEN 'B'
        WHEN marks >= 60 THEN 'C'
        WHEN marks >= 50 THEN 'D'
        ELSE 'F'
        END;

	SELECT student_id AS Student_ID, student_name AS Student_Name, marks AS Marks, grade AS Grade;
END$$

DELIMITER ;
        
CALL calculate_grade(101, 'Amit', 85); 
CALL calculate_grade(102, 'Priya', 72); 
CALL calculate_grade(103, 'Rahul', 45);
	

-- Q4. Calculate Employee Bonus: Create a stored procedure calculate_bonus that accepts employee name and salary and 
-- calculates the bonus (>=100000: 20%, >=50000: 15%, >=30000: 10%, Below 30000: 5%). 
-- Display employee name, salary, bonus percentage, bonus amount, and total salary. 
-- Test cases: CALL calculate_bonus('Amit', 120000); CALL calculate_bonus('Priya', 65000); CALL calculate_bonus('Rahul', 25000);
DELIMITER $$
DROP PROCEDURE IF EXISTS calculate_bonus$$

CREATE PROCEDURE calculate_bonus(IN employee_name VARCHAR(50), IN salary DECIMAL(10,2))
BEGIN
	DECLARE bonus_pct DECIMAL(5,2);
    DECLARE bonus_amount DECIMAL(10,2);
    DECLARE total_salary DECIMAL(10,2);
    
    SET bonus_pct = CASE
		WHEN salary >= 100000 THEN 20.00
        WHEN salary >= 50000 THEN 15.00
        WHEN salary >= 30000 THEN 10.00
        ELSE 5.00
	END;
    
    SET bonus_amount = (salary * bonus_pct) / 100;
    SET total_salary = salary + bonus_amount;
    
    SELECT 
		employee_name AS Employee_Name, salary AS Salary, 
		CONCAT(bonus_pct, '%') AS Bonus_Percentage, 
		bonus_amount AS Bonus_amount, 
		total_salary AS Total_Salary;
END $$
DELIMITER ;

 CALL calculate_bonus('Amit', 120000); 
 CALL calculate_bonus('Priya', 65000); 
 CALL calculate_bonus('Rahul', 25000);

-- Q5. Find Maximum of Three Numbers: Create a stored procedure find_maximum that accepts three integers and displays the largest number. 
-- Test cases: CALL find_maximum(25, 78, 45); CALL find_maximum(100, 50, 75); CALL find_maximum(30, 30, 20);
DELIMITER $$
DROP PROCEDURE IF EXISTS find_maximum$$
 
CREATE PROCEDURE find_maximum (IN a INT, IN b INT, IN c INT)

BEGIN
	DECLARE max INT;
    
    IF a >= b AND a >= c THEN 
		SET max = a;
    ELSEIF b >= c AND b >= a THEN 
		SET max = b;
    ELSE  SET max = c;
    END IF;

	SELECT a AS Num1, b AS Num2, c AS Num3, max as MAX;
END $$
DELIMITER ;

CALL find_maximum(25, 78, 45); 
CALL find_maximum(100, 50, 75); 
CALL find_maximum(30, 30, 20);

-- Q6. Employee Salary Analysis: Create a stored procedure salary_analysis that accepts employee name and salary. 
-- Determine category and allowance (>=100000: High, 20%; >=50000: Medium, 15%; Below 50000: Low, 10%). 
-- Display employee name, salary, category, allowance percentage, allowance amount, and final salary. 
-- Test cases: CALL salary_analysis('Amit', 120000); CALL salary_analysis('Priya', 60000); CALL salary_analysis('Rahul', 35000);
DELIMITER $$
DROP PROCEDURE IF EXISTS salary_analysis$$

CREATE PROCEDURE salary_analysis(IN employee_name VARCHAR(50), IN salary DECIMAL(10,2))
BEGIN
	DECLARE category VARCHAR(50);
	DECLARE allowance_pct DECIMAL (5, 2);
    DECLARE allowance_amount DECIMAL(10,2);
    DECLARE final_salary DECIMAL(10,2);
    
    CASE
		WHEN SALARY >= 100000 THEN 
			SET category = 'High' ;
			SET allowance_pct= 20.00;
		WHEN salary >= 50000 THEN
			SET category = 'Medium' ;
			SET allowance_pct= 15.00;
		ELSE 
			SET category = 'Low';
			SET allowance_pct = 10.00;
	END CASE;
    
    SET allowance_amount = (salary * allowance_pct) / 100;
    SET final_salary = salary + allowance_amount;
    
	SELECT employee_name, salary, category As Category,
    CONCAT(allowance_pct, '%') AS Allowance_Percentage,
    allowance_amount AS Allowance_Amount,
    final_salary AS Final_Salary;

END $$
DELIMITER ;

CALL salary_analysis('Amit', 120000); 
CALL salary_analysis('Priya', 60000); 
CALL salary_analysis('Rahul', 35000);

-- Q7. Electricity Bill Calculation: Create a stored procedure calculate_electricity_bill that accepts consumer name and units consumed. 
-- Calculate bill slab-wise (First 100: 2/unit, Next 100: 3/unit, Next 200: 5/unit, Above 400: 7/unit). 
-- Display consumer name, units consumed, and total bill amount. 
-- Test cases: CALL calculate_electricity_bill('Amit', 80); CALL calculate_electricity_bill('Priya', 150); CALL calculate_electricity_bill('Rahul', 350); CALL calculate_electricity_bill('Sneha', 500);
DELIMITER //

DROP PROCEDURE IF EXISTS  calculate_electricity_bill//

CREATE PROCEDURE calculate_electricity_bill( IN consumer_name VARCHAR(50), IN units INT)

BEGIN
	DECLARE total_bill DECIMAL(10,2) DEFAULT 0.00;
    
    DECLARE remaining INT;
    SET remaining = units;
    
    IF remaining > 400 THEN
		SET total_bill = total_bill + ((remaining - 400) * 7);
        SET remaining = 400;
	END IF;
	IF remaining > 200 THEN
		SET total_bill = total_bill + ((remaining - 200) * 5);
        SET remaining = 200;
	END IF;
    IF remaining > 100 THEN
		SET total_bill = total_bill + ((remaining - 100) * 3);
        SET remaining = 100;
	END IF;
    IF remaining > 0 THEN
		SET total_bill = total_bill + (remaining * 5);
	END IF;
    
    SELECT consumer_name AS Consumer_Name, units AS Units_Consumed, total_bill AS Total_Bill;
END //
DELIMITER ;
 
 CALL calculate_electricity_bill('Amit', 80); 
 CALL calculate_electricity_bill('Priya', 150); 
 CALL calculate_electricity_bill('Rahul', 350); 
 CALL calculate_electricity_bill('Sneha', 500);
