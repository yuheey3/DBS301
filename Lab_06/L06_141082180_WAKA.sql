-----------------------------------------------------
--LAB 6 DBS301
--Name: Yuki Waka
--ID#: 141082180
--Date: Oct.11,2019
------------------------------------------------------

--Question 1--
--SET AUTOCOMMIT ON (do this each time you log on) so any updates, 
--deletes and inserts are automatically committed before you exit from Oracle.

--Solution--
SET AUTOCOMMIT ON; 

--Question 2--
--Create an INSERT statement to do this.  Add yourself as an employee
--with a NULL salary, 0.21 commission_pct, in department 90, and Manager 100.  You started TODAY.  

--Solution--
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id, commission_pct,manager_id, department_id)
VALUES (207, 'Yuki', 'Waka', 'YUKI', '902.989.6229', '19-10-11','AD_VP', '0.21','100','90');

--Question 3--
--Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.

--Solution--
UPDATE employees
SET salary = 2500
Where last_name = 'Matos' OR last_name = 'Whalen';

--Question 4--
--Display the last names of all employees who are in the same department
--as the employee named Abel.

 --Solution--
SELECT last_name AS "Last Name"
    FROM employees
    WHERE department_id IN(
                SELECT DISTINCT(department_id)
                FROM employees
                WHERE (last_name) = 'Abel');
                
--Question 5--
--Display the last name of the lowest paid employee(s)

--Solution--
SELECT last_name AS "Last Name"
    FROM employees
    WHERE salary IN(
        SELECT MIN(salary)
            FROM employees);
    
--Question 6 --
--Display the city that the lowest paid employee(s) are located in.

--Solution--
SELECT city AS "City"
    FROM locations 
    WHERE location_id IN(
        SELECT location_id 
        FROM departments
        WHERE department_id IN(
            SELECT department_id
            FROM employees
            WHERE salary IN(
            SELECT MIN(salary)
            FROM employees)));
         
--Question 7 --
--Display the last name, department_id, and salary of the lowest paid employee(s) 
--in each department.  Sort by Department_ID. (HINT: careful with department 60)

--Solution--

SELECT last_name AS "Last Name", department_id AS "Department#", salary AS "Min Salary"
    FROM employees
    WHERE (department_id, salary) IN(
        SELECT department_id, MIN(salary)
        FROM employees
        GROUP BY department_id
        )
    ORDER BY department_id;
        
        
--Question 8 --

--Solution--
--Display the last name of the lowest paid employee(s) in each city
SELECT e.last_name AS "Last Name", city  AS"City"
    FROM employees e
    JOIN departments d
    USING (department_id)
    JOIN locations l
    USING(location_id)
    WHERE (salary, city) IN(
        SELECT MIN(e.salary), l.city
        FROM employees e
        JOIN departments d
        ON e.department_id = d.department_id
        JOIN locations l
        ON d.location_id = l.location_id
        GROUP BY l.city);
        

--Question 9 --
--Display last name and salary for all employees who earn less than 
--the lowest salary in ANY department.  
--Sort the output by top salaries first and then by last name.

--Solution--

SELECT last_name AS "Last Name", salary AS "Salary"
    FROM employees
    WHERE salary < ANY (
                        SELECT MIN(salary)
                        FROM employees
                        GROUP BY department_id
                        )
                        ORDER BY salary DESC, last_name;


--Question 10--
--Display last name, job title and salary for all employees whose salary
--matches any of the salaries from the IT Department. Do NOT use Join method.  
--Sort the output by salary ascending first and then by last_name

--Solution--

SELECT last_name AS "Last Name", job_id AS "Job Title", salary AS "Salary"
    FROM employees
    WHERE salary IN (
                     SELECT salary
                         FROM employees
                         WHERE department_id IN(
                            SELECT department_id
                                FROM departments
                                WHERE department_name ='IT'
                        ))
                        ORDER BY salary ASC, last_name;







  