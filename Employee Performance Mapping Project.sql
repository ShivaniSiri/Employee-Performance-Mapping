-- SQL PROJECT --
-- ScienceQtech Employee Performance Mapping



-- Problem Statement 1)
-- ********************
-- Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources

-- Creating database
Create database Employee;

-- Importing 3 tables into the Employee data base - A)data_science_team.csv, B)proj_table.csv, C)emp_record_table.csv 
-- 1) Use Employee database by right clicking on it
-- 2) Right Click on table appearing inside employee database dropdown
-- 3) Click on 'Table data import wizard' and complete the import process for all three tables

select * from data_science_team;
select * from emp_record_table;
select * from proj_table;

-- Since the tabel is newly added we need to change the datatype of all tables from text to relevant data type



-- Problem Statement 2)
-- ********************
-- > Create an ER diagram for the given employee database

 -- Click on database on from header and then click on reverse engineer.
 -- select the database we want make ER diagram of.
 -- complete the wizard
 -- create a 1:1 relation between Emp_Record_Table and Data_Science_Team
 -- Create a 1:n relation beween proj_table and Emp_Record_Table
 -- Take a screen shot and upload it into the LMS



-- Problem Statement 3)
-- ********************
-- > Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;



-- Problem Statement 4)
-- ********************
-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
	-- 1) less than two
	-- 2) greater than four 
	-- 3) between two and four

-- Method 01 - Not What it is expected
-- *********
-- 1) if the EMP_RATING is: LESS THAN TWO
select * from emp_record_table;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT as DEPARTMENT, EMP_RATING from emp_record_table where EMP_RATING < 2;

-- 2) if the EMP_RATING is: GREATER THAN FOUR
select * from emp_record_table;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT as DEPARTMENT, EMP_RATING from emp_record_table where EMP_RATING > 4;

-- 3) if the EMP_RATING is: BETWEEN TWO & FOUR
select * from emp_record_table;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT as DEPARTMENT, EMP_RATING from emp_record_table where EMP_RATING between 2 and 4;

-- Sadiq
-- Method 02 - Exactly What we need. A single query. A seprate column showing the results indicating the values
-- *********
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT, emp_rating,
case
	when emp_rating < 2 THEN 'Less than 2'
	when emp_rating < 4 then 'Between two and four'
	else 'Greater then 4'
end as emp_rating_Status
from emp_record_table ;




-- Problem Statement 5)
-- ********************
-- Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.

 select * from emp_record_table;
 select concat(First_NAME,' ',LAST_NAME) as 'NAME' from emp_record_table Where DEPT = 'Finance';




-- Problem Statement 6)
-- ********************
-- Write a query to list only those Employee who have someone reporting to them. Also, show the number of reporters (including the President).

-- 1st half of the problem statement 
 select * from emp_record_table Where role IN ('Manager','President')
 union
-- 2nd half of the problem statement
select count(*) As No_Of_Reporters from emp_record_table;

-- Sadiq
-- self join
select * from emp_record_table;

select m.EMP_ID, m.FIRST_NAME as ManagerName, e.FIRST_NAME as EmployeeName,
	count(*) over (Partition by m.FIRST_NAME)
    from emp_record_table m
    join emp_record_table e
    on e.MANAGER_ID = m.EMP_ID
    order by m.EMP_ID;
    



-- Problem Statement 7)
-- ********************
-- Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.

-- 1st Method - Without using UNION
select * from emp_record_table;
select * from emp_record_table Where Dept IN ('healthcare','finance');

-- 2nd Method - using Union
SELECT * FROM emp_record_table WHERE Dept = 'healthcare'
UNION
SELECT * FROM emp_record_table WHERE Dept = 'finance';




-- Problem Statement 8)
-- ********************
-- Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
    max(EMP_RATING) over(partition by dept) as Max_Emp_Rating    
    from emp_record_table;




-- Problem Statement 9)
-- ********************
-- Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

select * from emp_record_table;
SELECT ROLE, MIN(SALARY) AS Min_Salary, MAX(SALARY) AS Max_Salary FROM emp_record_table GROUP BY ROLE;

-- sadiq
select EMP_ID, FIRST_NAME, LAST_NAME,GENDER, DEPT,ROLE, SALARY,
    max(salary) over(partition by ROLE) as Max_Salary,
    min(salary) over(partition by ROLE) as Min_Salary
    from emp_record_table;




-- Problem Statement 10)
-- ********************
-- Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

select * from emp_record_table;

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, DEPT, COUNTRY, CONTINENT, SALARY, EMP_RATING,EXP,
	Rank() over(order by exp desc) as Rank_based_on_exp from emp_record_table;
-- sadiq(to avoid skip)
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, DEPT, COUNTRY, CONTINENT, SALARY, EMP_RATING,EXP,
	dense_Rank() over(order by exp desc) as Rank_based_on_exp from emp_record_table;
    





-- Problem Statement 11)
-- ********************
-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table

select * from emp_record_table;

create view Emp_country as
select emp_id,first_name,last_name,salary,country from emp_record_table where salary >6000 order by COUNTRY;

select * from Emp_country;




-- Problem Statement 12)
-- ********************
-- Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

select * from emp_record_table where EXP > 10;

-- sadiq ( e is given as alias name)
select * from emp_record_table;

select emp_id,first_name,salary,dept from(
select * from emp_record_table where exp > 10) e ;



-- Problem Statement 13)
-- ********************
-- Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.

-- A strored  procedure is created with the name of (EmpExp_more_than_3yr)
/*
CREATE PROCEDURE EmpExp_more_than_3yr()
BEGIN
Select * From emp_record_table where exp >3;
END
*/
call EmpExp_more_than_3yr();





-- Problem Statement 14)
-- ********************
-- Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
-- The standard being:
	-- A)For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
	-- B) For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
	-- C) For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
	-- D) For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
	-- E) For an employee with the experience of 12 to 16 years assign 'MANAGER'.

select * from emp_record_table;
select * from data_science_team;
select * from proj_table;

-- MOHIT POV CODE
/*
SELECT D.EMP_ID, D.FIRST_NAME, D.LAST_NAME, D.GENDER, D.ROLE AS ASSIGNED_ROLE, D.DEPT, D.EXP, P.PROJ_NAME, count(*) over () as 'No. of employees',
  CASE (01)
    WHEN D.exp <= 2 THEN 'JUNIOR DATA SCIENTIST'
    WHEN D.exp BETWEEN 2 AND 5 THEN 'ASSOCIATE DATA SCIENTIST'
    WHEN D.exp BETWEEN 5 AND 10 THEN 'SENIOR DATA SCIENTIST'
    WHEN D.exp BETWEEN 10 AND 12 THEN 'LEAD DATA SCIENTIST'
    WHEN D.exp BETWEEN 12 AND 16 THEN 'MANAGER'
    ELSE 'Stand_Not_Set'
  END AS ORG_STANDARD_ROLE,
 CASE
		WHEN D.ROLE = 
      CASE (01)
        WHEN D.exp <= 2 THEN 'JUNIOR DATA SCIENTIST'
        WHEN D.exp BETWEEN 2 AND 5 THEN 'ASSOCIATE DATA SCIENTIST'
        WHEN D.exp BETWEEN 5 AND 10 THEN 'SENIOR DATA SCIENTIST'
        WHEN D.exp BETWEEN 10 AND 12 THEN 'LEAD DATA SCIENTIST'
        WHEN D.exp BETWEEN 12 AND 16 THEN 'MANAGER'
        ELSE 'Stand_Not_Set'
      END
      THEN 'Match'
    ELSE 'No Match'
  END AS ROLE_MATCH
  FROM data_science_team d
	join emp_record_table E on d.emp_id = e.EMP_ID
	JOIN proj_table P ON E.PROJ_ID = P.PROJ_ID ;
*/

CALL CalculateEmployeeRoles();
    
-- sadiq POV

/*CREATE DEFINER=`root`@`localhost` FUNCTION `emp_status`(eid varchar(5)) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare ex int;
declare str varchar(50);
select Exp into ex from data_science_team where emp_id = eid;
if exp <= 2 then
set str = 'JUNIOR DATA SCIENTIST';
elseif ex <= 5 then 
set str = 'ASSOCIATE DATA SCIENTIST';
elseif ex <= 10 then
set str = 'SENIOR DATA SCIENTIST';
elseif ex <= 12 then 
set str = 'LEAD DATA SCIENTIST';
elseif ex <= 16 then 
set str = 'MANAGER';
end if;
RETURN str;
END
*/

select * from data_science_team;

Select *,emp_status(emp_id) from data_science_team;

select *,emp_status1(Emp_ID) from data_science_team;

-- Problem Statement 15) 
-- ********************
-- Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan

 select * from emp_record_table where FIRST_NAME = 'Eric';

-- sadiq pov(we can directly create an index)
create index idx_first_name on emp_record_table(first_name);
 select * from emp_record_table where FIRST_NAME = 'Eric';

-- to drop the index
drop index idx_first_name on emp_record_table;


-- Problem Statement 16) 
-- ********************
-- Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).


SELECT EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,SALARY,EMP_RATING, (0.05 * salary * EMP_RATING) AS bonus FROM emp_record_table;

-- sadiq POV
select salary *0.05 * emp_rating as bonus from emp_record_table;
select *,salary *0.05 * emp_rating as bonus from emp_record_table;


-- Problem Statement 17) 
-- ********************
-- Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.

-- Method 01
SELECT continent, country, AVG(salary) AS average_salary
FROM emp_record_table
GROUP BY continent, country;



SELECT AVG(salary) AS average_salary
FROM emp_record_table
GROUP BY continent, country
ORDER BY continent, country;

-- Method 02
SELECT
    continent,
    country,
    AVG(salary) OVER (PARTITION BY continent) AS average_salary_continent,
    AVG(salary) OVER (PARTITION BY country) AS average_salary_country
FROM
    emp_record_table
order BY
    continent, country;
    
    -- sadiq POV
    select emp_id,first_name,last_name,salary,country,continent,
    avg(salary) over(partition by continent,country)
    from emp_record_table;
