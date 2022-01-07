use employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name.
select * from employees where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya' order by first_name; #709 record returned | first person of the result is Irena Reutenauer | Last person of the result is Vidya Simmen

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.
select * from employees where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya' order by first_name, last_name; /*709 records returned | First person returned is Irena Acton | Last person returned is Vidya Zweizig*/

#Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name.
select * from employees where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya' order by last_name, first_name; /*709 records returned | First person returned is Irena Acton | Last person returned is Maya Zyda*/

#Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number.
select * from employees where last_name like 'e%e' order by emp_no; #899 records returned | First emp_no is 10021 (Ramzi Erde) | Last emp_no is 499648 (Ekawit Erde)

#Write a query to to find all employees whose last name starts and ends with 'E'
select * from employees where last_name like 'e%e' order by hire_date desc; #899 records returned | Newest employee is Teiji Eldridge (hire date 1999-11-27) | oldest employee is Sergi Erde (hire date 1985-02-02)

#Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
select * from employees where birth_date like '%-12-25' and hire_date between '1990-01-01' and '1999-12-31' order by hire_date asc; #362 records returned | The oldest employee is Alselm Cappello (hire date 1990-01-01) | the newest employees is Khun Bernini (hire date 1999-08-31