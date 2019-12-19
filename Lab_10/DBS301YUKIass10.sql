-- ***********************************
-- Lab 10 - DBS 301
-- TRANSACTIONS
-- November 25, 2019
-- Name: Yuki Waka
-- Student# : 141082180
-- ***********************************

--Question 1--
--1.Create table L10Cities from table LOCATIONS, but only for location numbers less than 2000
--(do NOT create this table from scratch, i.e. create and insert in one statement).
--You will have exactly 10 rows here.

CREATE TABLE L10Cities AS (
SELECT *
    FROM locations
    WHERE (location_id < 2000));
    
SELECT * FROM L10Cities;
DESCRIBE L10Cities;

--Question 2--
--2.Create table L10Towns from table LOCATIONS, but only for location numbers less than 1500 
--(do NOT create this table from scratch). This table will have same structure as table L10Cities. 
--You will have exactly 5 rows here.

CREATE TABLE L10Towns AS (
SELECT *
    FROM locations
    WHERE (location_id < 1500));
    
SELECT * FROM L10Towns;
DESCRIBE L10Towns;



--Question 3--
--Now you will empty your RECYCLE BIN with one powerful command.
--Then remove your table L10Towns, so that will remain in the recycle bin. 
--Check that it is really there and what time was removed. 
--Hint: Show RecycleBin,   Purge,  Flashback

SHOW RecycleBin;
DROP TABLE L10Towns;
SHOW RecycleBin;


--Question 4 --
--Restore your table L10Towns from recycle bin and describe it. 
--Check what is in your recycle bin now.

FLASHBACK TABLE L10Towns TO BEFORE DROP;
DESCRIBE L10Towns;
SHOW RecycleBin;


--Question 5--
--Now remove table L10Towns so that does NOT remain in the recycle bin. 
--Check that is really NOT there and then try to restore it. Explain what happened?

DROP TABLE L10Towns;
PURGE TABLE L10Towns;
SHOW recycleBin;
FLASHBACK TABLE L10Towns TO BEFORE DROP;
--It creates error, because L10Towns table is not in Recycle Bin.



--Question 6--
--Create simple view called CAN_CITY_VU, based on table L10Cities so that will contain 
--only columns Street_Address, Postal_Code, City and State_Province for locations only in CANADA. 
--Then display all data from this view.

CREATE VIEW CAN_CITY_VU AS (
    SELECT Street_Address, Postal_Code, City, State_Province 
    FROM L10Cities
    WHERE country_id IN ('CA'));
    
SELECT *FROM CAN_CITY_VU;    


--Question 7--
select * from L10cities;
--Modify your simple view so that will have following aliases instead of original column names: 
--Str_Adr, P_Code, City and Prov and also will include cities from ITALY as well. 
--Then display all data from this view. 

CREATE OR REPLACE VIEW CAN_CITY_VU AS(
    SELECT Street_Address AS "Str_Adr", Postal_Code AS "P Code", City AS "City", State_Province AS "Prov"
    FROM L10Cities
    WHERE country_id IN ('CA','IT'));
    
SELECT *FROM CAN_CITY_VU; 



--Question 8--

--Create complex view called vwCity_DName_VU, based on tables LOCATIONS and DEPARTMENTS, 
--so that will contain only columns Department_Name, City and State_Province for locations
--in ITALY or CANADA.
--Include situations even when city does NOT have department established yet. 
--Then display all data from this view.

CREATE VIEW vwCity_DName_VU AS (
    SELECT department_name, city, state_province
        FROM locations 
        LEFT JOIN departments
        USING(location_id)
        WHERE country_id IN ('CA','IT'));
        
SELECT * FROM vwCity_DName_VU;     



--Question 9--
--Modify your complex view so that will have following aliases instead of original column names:
--DName, City and Prov and also will include all cities outside United States

CREATE OR REPLACE VIEW vwCity_DName_VU AS (
    SELECT department_name AS "Dname", city AS "City", state_province AS "Prov"
    FROM locations 
     LEFT JOIN departments
     USING(location_id)
     WHERE country_id NOT IN ('US'));
     
SELECT * FROM vwCity_DName_VU;  



--Question 10--
--Create a transaction, ensuring a new transaction is started, and include all the SQL statements
--required to merge the Marketing and Sales departments into a single department
--“Marketing and Sales”. 
--Create a new department such that the history of employees departments remains intact. 
--The Sales staff will change locations to the existing Marketing department’s location.  
--All staff from both previous departments will change to the new department. 
--Add appropriate save points where the transaction could potentially be rolled back to (i.e. good checkpoints).
--Execute these statements, double check everything worked as intended, and then once it works 
--through a single execution, commit it. 
--If errors occur or the data is incorrect, you can rollback and rerun after the errors have been corrected in the SQL code.

SELECT * 
    FROM employees
    JOIN departments
    USING(department_id)
    WHERE department_id IN(20,80);

INSERT INTO departments VALUES(200, 'Marketing and Sales', NULL, 1800);

SAVEPOINT a;
SELECT * FROM departments;
UPDATE departments SET location_id = 1800
    WHERE department_id = 80;
    
SAVEPOINT b;    
SELECT * FROM departments;
UPDATE employees SET department_id = 200
WHERE department_id IN (20,80);

SAVEPOINT c;
SELECT * FROM employees;
--ROLLBACK to a;

COMMIT;



--Qurstion 11--
--Check in the Data Dictionary what Views (their names and definitions) are created so far in 
--your account. Then drop your vwCity_DName_VU and check Data Dictionary again. 
--What is different?

SELECT VIEW_NAME
FROM USER_VIEWS;

DROP VIEW vwCity_DName_VU;

SELECT VIEW_NAME
FROM USER_VIEWS;

--There is no vwCity_DName_VU in the data dictionary.


