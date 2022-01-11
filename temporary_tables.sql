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
add change_amount decimal;

update sakila_payment_temporary_table set change_amount = change_amount * 100;
#Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?