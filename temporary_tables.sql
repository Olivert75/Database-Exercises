use innis_1668;
/*Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.*/
select first_name, last_name, dept_name 
from employees 
join dept_emp using (emp_no)
join departments using (dept_no)
where to_date > now();

#Temporary table name : employees_with_departments (name of database.name of the table.rows name of the selected table)
create temporary table employees_with_departments as (
select employees.employees.first_name, employees.employees.last_name, employees.departments.dept_name 
from employees.employees 
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where to_date > now());

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
describe employees_with_departments;

alter table employees_with_departments
add full_name varchar(30);

#Update the table so that full name column contains the correct data
update employees_with_departments set full_name = concat(first_name,' ', last_name);

#Remove the first_name and last_name columns from the table.
alter table employees_with_departments
drop column first_name;

alter table employees_with_departments
drop column last_name;
#What is another way you could have ended up with this same table?
create temporary table employees_with_departments as (
select concat(employees.employees.first_name,' ', employees.employees.last_name) as full_name, employees.departments.dept_name 
from employees.employees 
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where to_date > now());

/*Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.*/
create temporary table sakila_payment_temporary_table as(
select * from sakila.payment); 

describe sakila_payment_temporary_table;

alter table sakila_payment_temporary_table
change amount change_amount decimal(6,2);

update sakila_payment_temporary_table set change_amount = change_amount * 100;

alter table sakila_payment_temporary_table
change change_amount cents_amount int;
#Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

-- create temporary table and name it
create temporary table current_avg_salary as(
select avg(employees.salaries.salary) as avg_salary, employees.departments.dept_name
from employees.salaries
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where employees.salaries.to_date > now() and employees.dept_emp.to_date > now()
group by employees.departments.dept_name);

-- create a columms for deviation and average for salary include historical and insert into temporary table

/* This is how to find the avg for salaries and standard deviation
	select avg(salary), std(salary) from employees.salaries;   
run this using emporloyees database and then copy the value or create a temporary table for this 
*/ 
alter table current_avg_salary 
add avg_salary_include_historical float not null;

alter table current_avg_salary
add standard_deviation float not null;

update current_avg_salary set avg_salary_include_historical = 63810.7448;
update current_avg_salary set standard_deviation = 16904.82828800014;

-- z score = (raw score - mean) / standard deviation
select *, ((avg_salary - avg_salary_include_historical)/standard_deviation) as Z_score 
from current_avg_salary
order by Z_score desc;

-- alternative way - create temporary table 
/*
create temporary table historic_avg_salary as(
select avg(salary) as historical_salary, std(salary) as std_deviation from employees.salaries);

create temporary table current_avg_salary as(
select avg(employees.salaries.salary) as avg_salary, employees.departments.dept_name
from employees.salaries
join employees.dept_emp using (emp_no)
join employees.departments using (dept_no)
where employees.salaries.to_date > now() and employees.dept_emp.to_date > now()
group by employees.departments.dept_name);

alter table current_avg_salary 
add avg_salary_include_historical float not null;

alter table current_avg_salary
add standard_deviations float not null;

alter table current_avg_salary
add z_score float not null;

update current_avg_salary set avg_salary_include_historical = (select historical_salary from historic_avg_salary);
update current_avg_salary set standard_deviations = (select std_deviation from historic_avg_salary);

update current_avg_salary set z_score = (avg_salary - avg_salary_include_historical) / standard_deviations;

select * from current_avg_salary order by z_score desc;
*/
