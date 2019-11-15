-----------------------------------------------------
--Name: Yuki waka
--ID#: 141082180
--Date: Sep.29,2019
--Purpose: Lab4 DBS301
------------------------------------------------------
--Question 1--
--Display the difference between the Average pay and Lowest pay in the company.  
-- Name this result Real Amount.  
--Format the output as currency with 2 decimal places.

--Q1 SOLUTION--
SELECT to_char(AVG (salary) - min (salary),'$999,999.99') AS "Real Amount"
    FROM employees;
    
--Question 2--  
--Display the department number and Highest, Lowest and Average pay per each department.
--Name these results High, Low and Avg.  
--Sort the output so that the department with highest average salary is shown first. 
--Format the output as currency where appropriate.    

--Q2 SOLUTION--
SELECT department_ID, to_char(max(salary),'$999,999.99') AS "High",
   to_char(min (salary),'$999,999.99') AS "Low",
    to_char(avg(salary),'$999,999.99') AS "AVG"
    FROM employees
    WHERE (department_Id IS NOT NULL)
    GROUP BY department_id
    ORDER BY AVG DESC;
    
 --Question3--
 --Display how many people work the same job in the same department.
 --Name these results Dept#, Job and How Many.
 --Include only jobs that involve more than one person.
 --Sort the output so that jobs with the most people involved are shown first.
 
 --Q3 Solution--
 SELECT department_ID AS "Dept#", job_ID AS"Job", count(job_ID) AS "How Many"
    FROM employees
    GROUP BY department_ID, job_ID
    HAVING (count (job_ID)) > 1
    ORDER BY  count(job_ID)DESC;
    
 --Question4--
 --For each job title display the job title and total amount paid each month for this type of the job.
 --Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $11,000.  
 --Sort the output so that top paid jobs are shown first.
 
--Q4 Solution--
SELECT job_ID AS "Job Title", to_char(sum(salary),'$999,999') AS "Total Amount Paid"
    FROM employees
    WHERE job_ID NOT IN('AD_PRES', 'AD_VP')
    GROUP BY job_ID
    HAVING sum(salary)> 11000
    ORDER BY sum(salary)DESC;
 
 
--Question5--
--For each manager number display how many persons he / she supervises.
--Exclude managers with numbers 100, 101 and 102 and 
--also include only those managers that supervise more than 2 persons. 
--Sort the output so that manager numbers with the most supervised persons are shown first.

--Q5 Solution--

SELECT manager_ID, count(manager_ID) AS "How Many"
    FROM employees
    WHERE manager_ID NOT IN (100,101,102)
    GROUP BY manager_ID
    HAVING count(manager_ID) > 2
    ORDER BY count(manager_ID) DESC;
    
 
--Question6--  
--For each department show the latest and earliest hire date, BUT
--exclude departments 10 and 20 
--exclude those departments where the last person was hired in this decade. 
-- Sort the output so that the most recent, meaning latest hire dates, are shown first.


--Q6 Solution--
SELECT department_ID, max(hire_date) AS "latest", min(hire_date) AS "earliest"
    FROM employees
    WHERE department_ID NOT IN (10,20)
    GROUP BY department_ID
    HAVING max(hire_date) < '2020-01-01'
    ORDER BY max(hire_date)DESC;
 

 
  
    
    
    



