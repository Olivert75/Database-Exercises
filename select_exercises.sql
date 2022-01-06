use albums_db;
describe albums;
#There are 6 rows in the alubms table
#There are 31 artist names in the ablums table
#id is the primary key for the albums table
#1961 is the oldest release date, 2011 is the most recent
select name from albums where artist = "Pink Floyd";
select release_date from albums where name = "Sgt. Pepper's Lonely Hearts Club Band";
select genre from albums where name = 'Nevermind';
select name from albums where release_date between 1990 and 1999;
select name from albums where sales < 20;
#Because we only specified genre as "rock" so the query will look the exact value
