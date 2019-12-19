-- *************************************
-- DBS301 - LAB 9
-- DML, DDL, CRUD
-- Nov 19, 2019
-- Name: Yuki Waka
-- Student#: 141082180
-- *************************************


--1.Create table L09SalesRep and load it with data from table EMPLOYEES table.
--Use only the equivalent columns from EMPLOYEE as shown below and only for people 
--in department 80.

--Solution--

CREATE TABLE L09SalesRep (
    RepId NUMBER (6),
    FName VARCHAR2(20),
    LName VARCHAR2 (25),
    Phone#	VARCHAR2(20),         
    Salary	NUMBER(8,2),                   
    Commission	NUMBER(2,2)
);
INSERT ALL
    INTO L09SalesRep VALUES(149,'Eleni', 'Zlotkey', '011.44.1344.429018', 10500, 0.2)
    INTO L09SalesRep VALUES(174, 'Ellen', 'Abel', '011.44.1644.429267',11000, 0.3)
    INTO L09SalesRep VALUES(176, 'Jonathon', 'Taylor','011.44.1644.429265', 8840, 0.2)
    SELECT 1 FROM dual;
COMMIT;


--Quetion 2 --
--2.Create L09Cust table.

--Solution--

CREATE TABLE L09Cust (
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30),
   CITY 		VARCHAR2(20),
   RATING		CHAR(1),
   COMMENTS	  VARCHAR2(200),
   SALESREP#	NUMBER(7) 
   );


INSERT ALL
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(501,'ABC LTD.', 'Montreal', 'C', 201)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(502,'Black Giant','Ottawa', 'B', 202)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(503,'Mother Goose', 'London', 'B', 202)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(701,'BLUE SKY LTD', 'Vancouver', 'B', 102)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(702,'MIKE and SAM Inc.', 'Kingston', 'A', 107)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(703,'RED PLANET', 'Mississauga', 'C', 107)
    INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP#) VALUES(717,'BLUE SKY LTD', 'Regina','D', 102)
SELECT 1 FROM dual;
COMMIT;


--Quetion 3--

--3.Create table L09GoodCust by using following columns but only if their rating is A or B.

--Solution--

CREATE TABLE L09GoodCust(
    CustId	NUMBER	(6),	
    "Name"	VARCHAR2(30),    
    "Location"	VARCHAR2(20),     
    RepId	NUMBER(7)    
    );


INSERT INTO L09GoodCust
    SELECT CUST#, CUSTNAME, CITY,SALESREP#
        FROM L09Cust
        WHERE RATING IN ('A', 'B');
        
--Quetion 4-- 
--Now add new column to table L09SalesRep called JobCode that
--will be of variable character type with max length of 12. Do a DESCRIBE L09SalesRep to ensure it executed.

--Solution--

ALTER TABLE L09SalesRep 
    ADD JobCode VARCHAR2 (12);
    
SELECT * FROM L09SalesRep;

--Quetion 5-- 

--5.Declare column Salary in table L09SalesRep as mandatory one and Column 
--Location in table L09GoodCust as optional one. You can see location is already optional.

--Solution--

ALTER TABLE L09SalesRep 
 MODIFY Salary NOT NULL;

ALTER TABLE L09SalesRep 
 MODIFY LNAme NOT NULL;        
 
--Lengthen FNAME in L09SalesRep to 37. 
--You can only decrease the size or length of Name in L09GoodCust to the maximum length 
--of data already stored. Do it by using SQL and not by looking at each entry and counting 
--the characters. May take two SQL statements

ALTER TABLE L09SalesRep
    MODIFY FName VARCHAR2(37);
    
--Quetion 6--
--Now get rid of the column JobCode in table L09SalesRep in a way that will not affect daily performance. 

ALTER TABLE L09SalesRep
    DROP COLUMN JobCode;
    
--Quetion7--
--Declare PK constraints in both new tables ? RepId and CustId

ALTER TABLE L09SalesRep
    ADD CONSTRAINT sale_repid_pk PRIMARY KEY (RepId);

ALTER TABLE L09GoodCust
    ADD CONSTRAINT goodcust_custid_pk PRIMARY KEY (CustId);    
    
--Quetion8--
--Declare UK constraints in both new tables ? Phone# and Name

ALTER TABLE L09SalesRep
    ADD CONSTRAINT sales_phone#_uk UNIQUE (Phone#);


ALTER TABLE L09GoodCust
    ADD CONSTRAINT goodcust_name_uk UNIQUE ("Name");
    
--Quetion9--    
--Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be not more than 50%.

ALTER TABLE L09SalesRep 
    ADD CONSTRAINT sale_salary_ck CHECK(salary >= 6000 AND salary <= 12000)
    ADD CONSTRAINT sale_commission_ck CHECK(commission <= .50);

--Quetion 10--
--Ensure that only valid RepId numbers from table L09SalesRep may be 
--entered in the table L09GoodCust. Why this statement has failed?

-- INSERT INTO L09GoodCust (repid)
 --SELECT repid FROM L09SalesRep;
 
-- It is because CustId is Primary key, it can't be null.
--But L09SalesRep dosen't have CustId.

--Quetion 11--
-- Firstly write down the values for RepId column in table L09GoodCust and then make
--all these values blank. Now redo the question 10. Was it successful? 

--yes. Because RepId is primary key and L09GoodCust has RepId for now.
--So It can insert to L09SalesRep

--Quetion 12--
--Disable this FK constraint now and enter old values for RepId in table 
--L09GoodCust and save them. Then try to enable your FK constraint. What happened? 

--The FK is enabled, since its value is the same between L09SalesRep and L09GoodCus.

--Quetion 13--
--Get rid of this FK constraint. Then modify your CK constraint from question 9 to
--allow Salary amounts from 5000 to 15000.

ALTER TABLE L09SalesRep
    DROP CONSTRAINT sale_salary_ck;

ALTER TABLE L09SalesRep
    ADD CONSTRAINT sale_salary_ck CHECK(salary >= 5000 AND salary <= 15000);
    
--Quetion 14--    
--Describe both new tables L09SalesRep and L09GoodCust and then show all constraints for these two 
--tables by running the following query:   

SELECT constraint_name, constraint_type, 
      search_condition, table_name
   FROM user_constraints
   WHERE lower(table_name) IN ('l09salesrep','l09goodcust')
   ORDER BY table_name, constraint_type;


