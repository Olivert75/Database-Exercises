use albums_db;

#There are 6 rows in the alubms table
#There are 23 unique artist names in the ablums table
#id is the primary key for the albums table
#1961 is the oldest release date, 2011 is the most recent
#The name of all albums by Pink Floyd
select name from albums where artist = "Pink Floyd";
#The year Sgt. Pepper's Lonely Hearts Club Band was released
select release_date from albums where name = "Sgt. Pepper's Lonely Hearts Club Band";
#The genre for the album Nevermind
select genre from albums where name = 'Nevermind';
#Which albums were released in the 1990s
select name from albums where release_date between 1990 and 1999;
#Which albums had less than 20 million certified sales
select name from albums where sales < 20;
#Because we only specified genre as "rock" so the query will look the exact value
