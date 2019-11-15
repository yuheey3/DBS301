-----------------------------------------------------
--Name: Yuki waka
--ID#: 141082180
--Date: Sep.22,2019
--Purpose: Lab3 DBS301
------------------------------------------------------
--Question 1--
--Write a query to display the tomorrow's date
--format: September 15th of year 2019

--Solution--
SELECT to_char(sysdate + 1, 'Month" "dd"th of year "yyyy') AS "Tommorow"
    FROM dual;  
    

--Question 2--    
--For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary increased by 4%
--and expressed as a whole number.  Label the column “Good Salary”.  
--Add column called "Annual Pay Increase" that subtracts the old salary from the new salary and multiplies by 12. 

--Solution--
SELECT last_name,first_name,salary,salary * 1.04 AS "Good Salary", (((salary * 1.04) - salary)*12) AS "Annual Pay increase"
    FROM employees
    WHERE (department_id = 20 OR department_id = 50 OR department_id = 60);
    
 
--Question3--
--Displays the employee’s Full Name and Job Title 
--Format: DAVIES, CURTIS is ST_CLERK 
--last name ends with D and first name starts with C or K
--make appropriate label
--Sort the resulty by the employees'last names.

--Solution--
SELECT upper (last_name)||', '|| upper (first_name) ||' is '|| job_id AS "Full Name and Job Title"
    FROM employees
    WHERE last_name LIKE '%s' AND (first_name LIKE 'C%' or first_name LIKE 'K%')
    ORDER BY last_name;


--Question 4--
--Employee hired before 2012, display the employee’s last name, hire date
--and calculate the number of YEARS between TODAY and the date the employee was hired.

--Solution--
SELECT last_name, hire_date,
TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12,0) AS "Years woreked"
    FROM employees
    WHERE hire_date < to_date('12312011', 'mmddyyyy')
    ORDER BY hire_date;
    
    
--Question 5--
--displays the city names, country codes and state province names.
--cities that starts with S and has at least 8 characters in their name. 
--If city does not have a province name assigned, then put Unknown Province.  

--Solution--
SELECT city,country_id, NVL(state_province,'Unknown Province') AS "STATE_PROVINCE"
    FROM locations
    WHERE upper(city) LIKE 'S_%_%_%_%_%_%_%';


--Question 6--
--Display each employee’s last name, hire date, and salary review date, 
--which is the first Thursday after a year of service, but only for those hired after 2017.  
--Label the column REVIEW DAY. 
--Format the dates to appear in the format like:
--Format: WEDNESDAY, SEPTEMBER the Eighteenth of year 2019
--Sort by review date

--Solution--
SELECT last_name,hire_date, to_char(next_day(hire_date + 365, 'Thursday'),'DAY, MONTH" the "fmDdspth" 
of year "YYYY') AS "REVIEW DAY"
    FROM employees
     WHERE hire_date >= to_date('01012017', 'mmddyyyy')
     ORDER BY hire_date;



    