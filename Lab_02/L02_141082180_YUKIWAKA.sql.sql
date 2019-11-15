
-----------------------------------------------------
--Name: Yuki waka
--ID#: 141082180
--Date: Sep.11,2019
------------------------------------------------------

--Question 1--
-- Display th employee_id, lastname and salary of employees earning
--in the range of $8,000 to $11,000. Sort the output by top salaries
--first and then by last name.

--Solution--
SELECT employee_id, last_name, to_char(salary, '$999,999.99')AS "SALARY"
    FROM employees
    WHERE (salary >= '8000') AND (salary <= '11000')
    ORDER BY salary DESC,last_name;
     
--Question 2--
--Display only if work as Programmers or Sales Representatives. 

--Solution--
SELECT employee_id, last_name,  to_char(salary, '$999,999.99') AS "SALARY", job_id
    FROM employees
    WHERE (salary >= 8000 AND salary <=11000)
    AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
    ORDER BY salary DESC,last_name;
    
--Question3--
--Find high salary and low salary employees.It displays the same job titles but for people 
--who earn outside the given salary range from question 1.

--Solution--

SELECT employee_id, last_name,  to_char(salary, '$999,999.99')AS "SALARY"
    FROM employees
    WHERE (salary < 8000  OR salary > 11000)
    AND (job_id = 'IT_PROG' OR job_id = 'SA_REP')
    ORDER BY salary DESC,last_name;
 

--Question 4--
--Display the last name, job_id and salary of employees hired before 2018.
--List the most recently hired employees first.

--Solution-
SELECT last_name, job_id,  to_char(salary, '$999,999.99')AS "SALARY"
    FROM employees
    WHERE hire_date < to_date ('2018-01-01', 'yyyy-mm-dd')
    ORDER BY hire_date DESC;
    
--Question5--
--Displays only employees earning more than $11,000. List the output by job title alphabetically 
--and then by highest paid employees.

--Solution-
SELECT last_name, job_id AS "Job Title", to_char(salary, '$999,999.99')AS "SALARY"
    FROM employees
    WHERE  (salary > 11000)
    ORDER BY job_id, salary DESC;
    
--Question 6--
--Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere. T
--e output should look like

--Solution--
SELECT job_id AS "Job Title", first_name ||' '|| last_name AS "Fullname"
    FROM employees
    WHERE upper (first_name) LIKE'%E%'
    ORDER BY job_id;

--Question 7--
--Display the address of the various locations where offices are located.
--Add a parameter to the query such that the user can enter all, or part of, 
--the city name and all locations from the resultant cities will be shown.

--Solution--

SELECT *
    FROM locations
    WHERE upper (city) LIKE upper('%&city%');



    