-- *******Employees Database******

use employees;

#How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

-- find average for each department and manager salary for that department
select emp_no, dept_no, dept_name, salary, avg_salary_by_departments
from (
select emp_no, dept_no, salary
from dept_manager
join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
) as manager_salary
join (
select dept_no, dept_name, avg(salary) as avg_salary_by_departments
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date > now() and dept_emp.to_date > now()
group by dept_no
) as deparments_avg using(dept_no);

-- using query above to compare department manager get less than the avg salary
select emp_no, dept_no, dept_name, salary, avg_salary_by_departments,
case 
when salary > avg_salary_by_departments then 'Higher than average salary'
when salary < avg_salary_by_departments then 'Lower than average salary'
else 'Same as average'
end as 'Manager salary relation to average salary'
from (
select emp_no, dept_no, salary
from dept_manager
join salaries using (emp_no)
where dept_manager.to_date > now() and salaries.to_date > now()
) as manager_salary
join (
select dept_no, dept_name, avg(salary) as avg_salary_by_departments
from departments
join dept_emp using (dept_no)
join salaries using (emp_no)
where salaries.to_date > now() and dept_emp.to_date > now()
group by dept_no
) as deparments_avg using(dept_no);

-- ********World Database********

use world;

#What languages are spoken in Santa Monica?
select language, percentage from countrylanguage 
where countrycode in ('USA')
order by percentage;

#How many different countries are in each region?
select region, count(*) as num_countries 
from country 
group by region
order by num_countries;

#What is the population for each region?
select region, sum(population) as total_population
from country 
group by region 
order by total_population desc;

#What is the population for each continent?
select continent, sum(population) as total_population
from country 
group by continent 
order by total_population desc;

#What is the average life expectancy globally?
select avg(lifeexpectancy) as avg_life_expectancy
from country;

#What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
-- Region
select region, avg(lifeexpectancy) as avg_life_expectancy
from country
group by region
order by avg_life_expectancy;

-- Continent
select continent, avg(lifeexpectancy) as avg_life_expectancy
from country
group by continent
order by avg_life_expectancy;

-- ******Bonus******
#Find all the countries whose local name is different from the official name
select name, localname 
from country 
where name not like localname;

#How many countries have a life expectancy less than x? (pick any country for x)
select count(*) as num_countries_lifeexpectancy_less_than_vietnam from country
where lifeexpectancy < (
select lifeexpectancy
from country 
where name in ('vietnam') order by name);
#What state is city x located in?
select name, district, countrycode
from city 
where name like '%sydney%';

#What region of the world is city x located in? Look at the relation between city and country (connect by code)
select city.name as 'City Name', city.district as 'District', country.name as 'Country Name', country.region as 'Region'
from country
join city on city.countrycode = country.code
where city.name like '%tokyo%';

#What country (use the human readable name) city x located in?
select city.name as 'City Name', country.name as 'Country Name'
from city
join country on country.code = city.countrycode
where city.name like '%Belg%';

#What is the life expectancy in city x?
select lifeexpectancy
from country
join city on city.countrycode = country.code
where city.name like '%tokyo%';