create database data_analyst_case_study;

use data_analyst_case_study;

select *
from table1;

select *
from table2;

--1. Identify top 3 transactions for each Region based on Sales.
with top_3_transactions as (
select Emp_ID, Region, Sales, row_number() over (partition by Region order by Sales desc) as SalesRank
from Table1
)

select Emp_ID, Region, Sales
from top_3_transactions
where SalesRank <= 3;

--2. Change the Date format (MM/DD/YYYY) (Posting Date) (Main Table)
select FORMAT(CONVERT(datetime, Date, 103), 'MM/dd/yyyy') as Date
from Table1     
/*Now this is not the permanent change, if we want to change the date format permanently,
then we have to update the table like this:

update Table1
set Date = FORMAT(CONVERT(datetime, Date, 103), 'MM/dd/yyyy');

*/

--3. Calculate the % of sales and % Discount in the above table
select Emp_ID, Name, Sales, Discounts,
ROUND((Sales * 100 / (select SUM(Sales) from Table1)), 2) as [%sales],
ROUND((Discounts*100 / (select SUM(Discounts) from Table1)), 2) as [%discount]
from Table1;

/*for permanent changes:

UPDATE Table1
SET [%Sales] = (Sales * 100) / (select SUM(Sales) from Table1),
    [%Discount] = (Discounts * 100) / (select SUM(Discounts) from Table1);

*/

--4. Write the SQL query to update the Category in table 1 using reference table 2
select t1.Emp_ID, t1.Name, t1.Department, t1.Sales, t2.Category
from Table1 t1
left join Table2 t2 
on t1.Department = t2.Department;

/*for permanent changes:

update t1
set t1.Category = t2.Category
from Table1 t1
join Table2 t2 
on t1.Department = t2.Department;

*/

--5. Find the minimum and maximum sales of each Department
select Department, MIN(Sales) as min_sales, MAX(Sales) as max_sales
from Table1
group by Department;

--6. Write the SQL query to Add the rank of each Emp ID based on total sales.
select Emp_ID, Sales, rank() over (order by Sales desc) as SalesRank
from Table1;