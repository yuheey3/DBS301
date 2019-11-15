-----------------------------------------
-- Name: YUKI WAKA
-- ID#: 141082180
-- Date: Sept 5, 2019
-- Purpose: Lab 1 DBS301
-----------------------------------------

--Question 1 -
--Which one of these tables appeared to be the widest? or longest? 
-- Q1 Soltion --
SELECT *
    FROM employees;
SELECT *
    FROM departments;
SELECT *
    FROM job_history;
    
--Employee table is the longest and widest table than other tables.

--Question 2-
--If the following SELECT statement does NOT execute successfully, how would you fix it?
--SELECT last_name “LName”, job_id “Job Title”, 
--       Hire Date “Job Start”
--       FROM employees;

-- Q2 Solution --
SELECT last_name AS "LName", job_id AS "Job Title", hire_date AS "Job Start"
       FROM employees;

-- I used alias 'AS' to make titles of colums.
-- Changed (“) to (") after AS command.
--  Hire Date -> hire_date : Field names should be in lower-case and  '_'is missing. 


--Question 3--
--There are THREE coding errors in this statement. Can you identify them?
-- Then, correct them and provide a working statement.
--SELECT employee_id, last name, commission_pct Emp Comm,
--FROM employees;

-- Q3 Solution--
SELECT employee_id, last_name, commission_pct AS "Emp Comm"
    FROM employees;
    
--1.last name -> last_name: '_' is missing.
--2. AS command is needed to make a title of colum.
--3. The end of the Select statement, "," is unnecessary.


-- Question 4--
--What command would show the structure of the LOCATIONS table?
--Q4 Solution --
SELECT *
    FROM locations;
    
-- Question 5--
--Create a query to display the output shown below. 
--BONUS: if you can only show the country code if there is no province

--Q5 Solution --
SELECT location_id AS "City#", city AS "City", state_province ||' IN THE '|| country_id AS "Province with Country Code"
    FROM locations;



       
