use employees;
#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
select * from employees where first_name in ('Irena','Vidya','Maya'); #709 records returned
#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN
select * from employees where first_name = "Irena" or first_name = "Vidya" or first_name = "Maya"; #709 records returned
#Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male.
select * from employees where first_name ="Irena" or first_name = "vidya" or first_name = "Maya" and gender = "M"; #441 record returned
#Find all current or previous employees whose last name starts with 'E'
select * from employees where last_name like "e%"; #7330 record returned
#Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E (part 1) #How many employees have a last name that ends with E, but does not start with E? (part 2)
select * from employees where last_name like "e%" or last_name like "%e"; # 30723 record returned
select * from employees where last_name not like "e%" and last_name like "%e"; #23393 records return 
#Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E #How many employees' last names end with E, regardless of whether they start with E?
select * from employees where last_name like "e%e"; #889 records returned
#select * from employees where last_name like "%e" or last_name not like "e%";
#Find all current or previous employees hired in the 90s
select * from employees where hire_date between '1990-01-01' and '1999-12-31'; #135214 records returned
#Find all current or previous employees born on Christmas
select * from employees where birth_date like '%-12-25'; #842 records returned
#Find all current or previous employees hired in the 90s and born on Christmas. 
#select * from employees where birth_date like '%-12-25' and hire_date >= '1990-01-01';
#Find all current or previous employees with a 'q' in their last name.
select * from employees where last_name like "%q%"; #1873 records returned
#Find all current or previous employees with a 'q' in their last name but not 'qu'
select * from employees where last_name like "%q%" and last_name not like "%qu%"; #547 records returned
