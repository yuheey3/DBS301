-----------------------------------------------------
--LAB 5 DBS301
--Name: Yuki Waka
--ID#: 141082180
--Date: Oct.9,2019
------------------------------------------------------

--Question 1--
--1. Display the department name, city, street address and postal code for departments sorted 
--by city and department name.

--Solution--
SELECT department_name, city, street_address, postal_code
    FROM departments d, locations l
    WHERE d.location_id = l.location_id
    ORDER BY city, department_name;

--Question 2--    

--2.Display full name of employees as a single field using format of “Last, First”, 
--their hire date, salary, department name and city, but only for departments with 
--names starting with an A or S sorted by department name and employee name. 

--Solution--
SELECT last_name || ', ' || first_name AS "Full name", hire_date, salary, department_name, city
    FROM employees, departments ,locations
    WHERE  employees.department_id = departments.department_id 
    AND departments.location_id = locations.location_id 
    AND (department_name  LIKE 'S%' OR department_name LIKE 'A%')
    ORDER BY department_name, last_name,first_name;
    
--Question 3--   
--3.Display the full name of the manager of each department in states/provinces of Ontario, 
--New Jersey and Washington along with the department name, city, postal code and province name.  
--Sort the output by city and then by department name.

--Solution--
SELECT first_name|| ' ' || last_name AS "Full name", department_name, city, postal_code, state_province
    FROM employees,departments,locations
    WHERE employees.employee_id = departments.manager_id
    AND departments.location_id = locations.location_id
    AND(state_province = 'Ontario' OR state_province = 'New Jersey' OR state_province = 'Washington')
    ORDER BY city, department_name;
    
--Question 4--
--Display employee’s last name and employee number along with their manager’s last name and manager number. 
--Label the columns Employee, Emp#, Manager, and Mgr# respectively.

--Solution--
SELECT e.last_name AS "Employee", e.employee_id AS "Emp#", m.last_name AS "Manager", e.manager_id AS "Mgr#"
    FROM employees e, employees m 
    WHERE e.manager_id = m.employee_id;
    
--Question 5--
--Display the department name, city, street address, postal code and country name 
--for all Departments. Use the JOIN and USING form of syntax.  Sort the output by department name descending.

--Solution--
SELECT department_name,city, street_address, postal_code, country_name
    FROM departments 
    LEFT OUTER JOIN locations USING(location_id)
    JOIN countries USING(country_id)
    ORDER BY department_name DESC;
    
--Question 6-- 
--Display full name of the employees, their hire date and salary together with their department name,
--but only for departments which names start with A or S.
--Full name should be formatted:  First / Last. 
--Use the JOIN and ON form of syntax.
--Sort the output by department name and then by last name.

--Solution--
SELECT first_name || '/' || last_name AS "Full name", hire_date, to_char(salary, '$999,999')AS"Salary" ,department_name
    FROM employees LEFT OUTER JOIN departments
    ON employees.department_id = departments.department_id
    WHERE department_name LIKE 'A%' OR department_name LIKE 'S%'
    ORDER BY department_name, last_name;
    
--Question 7--
--Display full name of the manager of each department in provinces Ontario, New Jersey and Washington
--plus department name, city, postal code and province name. 
--Full name should be formatted: Last, First.  
--Use the JOIN and ON form of syntax.
--Sort the output by city and then by department name. 

--Solution--
SELECT last_name|| ', ' || first_name AS "Full name", department_name, city, postal_code, state_province
    FROM employees JOIN departments
    ON employees.employee_id = departments.manager_id
    JOIN locations 
    ON departments.location_id = locations.location_id
    WHERE state_province = 'Ontario' OR state_province = 'New Jersey' OR state_province = 'Washington'
    ORDER BY city, department_name;
       
--Question 8--
--Display the department name and Highest, Lowest and Average pay per each department. Name these results High, Low and Avg.
--Use JOIN and ON form of the syntax.
--Sort the output so that department with highest average salary are shown first.

--Solution--
SELECT department_name, to_char(NVL(MAX(salary),0), '$999,999') AS "High", to_char(NVL(MIN(salary),0),'$999,999') AS "Low", 
    to_char(NVL(AVG(salary),0), '$999,999') AS "Avg"
    FROM departments  LEFT OUTER JOIN employees
    USING (department_id)
    GROUP BY department_name
    ORDER BY NVL(MIN(salary),0) DESC;
   
--Question 9-
--Display the employee last name and employee number along with their manager’s last name and manager number. 
--Label the columns Employee, 
--Emp#, Manager, and Mgr#, respectively. 
--Include also employees who do NOT have a manager and also employees who do NO
--supervise anyone (or you could say managers without employees to supervise).

--Solution--
SELECT NVL(e.last_name, 'None') AS "Employee", NVL(e.employee_id, 0) AS "Emp#", NVL(m.last_name,'None') AS "Manager", 
    NVL(e.manager_id,0) AS "Mgr#"
    FROM employees e FULL OUTER JOIN employees m 
    ON e.manager_id = m.employee_id;


    
    


    
    




