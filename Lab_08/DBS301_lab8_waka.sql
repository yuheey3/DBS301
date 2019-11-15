--------------------------------------------
--Name: Yuki Waka
--Student#: 141082180
--DBS301 Lab 8
--Date: Nov.12, 2019
--------------------------------------------

--Question 1--
--Display the names of the employees whose salary is the same as the lowest salaried employee in any department.

--Solution--

SELECT first_name ||' '||last_name AS "Full Name"
    FROM employees
    WHERE salary = ANY (
        SELECT min(salary)
            FROM employees
            );
         
--Question 2--
--Display the names of the employee(s) whose salary is the lowest in each department.

--Solution--
SELECT first_name || last_name AS "Full Name"
    FROM employees
    WHERE (salary, department_id) IN (
        SELECT min(salary),department_id
            FROM employees
            GROUP BY department_id
        );
        
--Question 3--
--Give each of the employees in question 2 a $120 bonus.

--Solution--
SELECT first_name || last_name AS "Full Name", salary + 120 AS "Bonus Salary"
    FROM employees
    WHERE (salary, department_id) IN (
        SELECT min(salary),department_id
            FROM employees
            GROUP BY department_id
        );
        
--Question 4--
--Create a view named vwAllEmps that consists of all employees includes employee_id, 
--last_name, salary, department_id, department_name, city and country (if applicable)

--Solution--

select * from countries;
select *from locations;
select *from departments;
DROP VIEW  vwALLEmps;
CREATE VIEW vwALLEmps AS 
    SELECT employee_id, last_name, salary,
    department_id, department_name,
    city, country_name
        FROM employees 
        JOIN departments
        USING (department_id) 
        JOIN locations 
        USING (location_id)
        JOIN countries
        USING(country_id);
        
--Question 5--
--5 Use the vwAllEmps view to:
--a. Display the employee_id, last_name, salary and city for all employees

SELECT employee_id, last_name, salary, city
FROM vwAllEmps;

--b. Display the total salary of all employees by city

SELECT sum(salary) AS"Total Salary", city
    FROM vwAllEmps
    GROUP BY city;
    
--c. Increase the salary of the lowest paid employee(s) in each department by 120

UPDATE vwALLEmps
SET salary = salary + 120
WHERE (salary,department_id) = any(
SELECT min(salary), department_id
    FROM vwAllEmps
    GROUP BY department_id);

--d. What happens if you try to insert an employee by providing values for all columns in this view?

INSERT INTO vwAllEmps
VALUES(300, 'WAKA', 30000, 90, 'Sales', 'Tronto', 'Canada');

--Insertion dosen't work. I think the view was created from four tables.

--e. Delete the employee named Vargas. Did it work? Show proof.

DELETE FROM vwAllEmps
WHERE last_name = 'Vargas';

--it works.

SELECT last_name
FROM vwAllemps
WHERE last_name = 'Vargas';

--Question 6--
--Create a view named vwAllDepts that consists of all departments and 
--includes department_id, department_name, city and country (if applicable)

--Solution--

CREATE VIEW  vwAllDepts AS
    SELECT department_id, department_name, city, country_name
        FROM departments
        JOIN locations
        USING(location_id)
        JOIN countries
        USING(country_id);

--Question 7--
--7 Use the vwAllDepts view to:
--a. For all departments display the department_id, name and city

SELECT department_id, department_name, city
    FROM vwAllDepts;
    
--b. For each city that has departments located in it display the number of departments by city

SELECT count(department_id)AS "#Dept", city
     FROM vwAllDepts
     GROUP BY city;
        
--Question 8--
-- Create a view called vwAllDeptSumm that consists of all departments and 
--includes for each department: department_id, department_name, number of employees, 
--number of salaried employees, total salary of all employees. 
--Number of Salaried must be different from number of employees.
--The difference is some get commission.

--Solution--

CREATE VIEW vwAllDeptSumm AS
    SELECT  department_id, department_name, count(employee_id) Employee, 
    count(commission_pct) "Salaried Emp", sum(salary) "Total Salary"
    FROM employees
    JOIN departments
    USING(department_id)
    GROUP BY department_id, department_name;
    
--Question 9--
-- Use the vwAllDeptSumm view to display department name and number of employees for departments 
--that have more than the average number of employees 

SELECT department_name, Employee
    FROM vwAllDeptSumm
    WHERE Employee > (
        SELECT AVG(Employee) FROM vwAllDeptSumm);
        
--Question 10--
--A Use the GRANT statement to allow another student (Neptune account) to retrieve data 
--for your employees table and to allow them to retrieve, insert and update data 
--in your departments table. Show proof

GRANT SELECT ON employees TO dbs301_193a25;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_193a25;

SELECT * FROM USER_TAB_PRIVS;

--B Use the REVOKE statement to remove permission for that student to insert
--and update data in your departments table

REVOKE INSERT, UPDATE ON departments FROM dbs301_193a25;

SELECT * FROM USER_TAB_PRIVS;


    


      
        
        
        
        
        