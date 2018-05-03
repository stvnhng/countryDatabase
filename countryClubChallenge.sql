-- Set Up
-- Create a new database called country_club and connect to it
-- Create a Members table
-- A serial primary key, an incrementing unique ID value for each row. Each row represents a member.
-- Surname, such as 'Smith'.
-- Firstname, such as 'Dan'.
-- Address, such as '23 Highway Way, Boston'.
-- Zipcode, such as 23423
-- Telephone, such as '123-344-2332'.
-- Recommended by, which references the members id who refered them, so that we can keep track of who recommends the most people
-- Join Date, to keep track of the longest standing members.
-- CREATE TABLE members (
--   id serial PRIMARY KEY,
--   surname varchar,
--   first_name varchar,
--   address varchar,
--   zipcode integer,
--   telephone varchar,
--   recommended_by integer REFERENCES members(id),
--   join_date timestamp without time zone
--   );
-- Create Facilities table
-- A serial primary key, an incrementing unique ID value for each row. Each row represents a facility.
-- Name, such as 'Tennis Court 1'.
-- Members Cost, such as 25.
-- Guest Cost, such as 1000.
-- Initial Out Lay, such as 10000, to show how much it cost to build.
-- Monthly Maintenance, such as 500, to show cost of maintaining.
-- Create Bookings table
-- A serial primary key, an incrementing unique ID value for each row. Each row represents booking.
-- Foreign Key reference to the facility table (see an example of how to do this in the Members table hint).
-- Foreign Key reference to the members table.
-- Start time, to let the member know when the session begins.
-- Slots, to show how many open spots there are for the session.
-- Import Data Into the Database
-- Now that the database is created and tables are in place, we need to fill those tables with some data so we have something to query.
--
-- Go to the LEARN wiki and clone the repository onto the desktop.
-- Open with Atom and find the club_data.sql file.
-- Copy the first set of data labeled members (starts at line 4063) Include the \. at the end.
-- Open up a terminal, make sure you are connected to the country_club database through psql, and paste in the copied data.
-- Hit Enter and the data will fill in the members table.
-- Do the same thing for the facilities data and then the bookings data.
-- Epic 2 Query the Database using JOINs on the Foreign Keys
-- Produce a list of start times for bookings by members named 'David Farrell'?
--
-- Hint: Remember that a JOIN is selecting all records from Table A and Table B, where the join condition is met.

SELECT start_time
FROM bookings b JOIN members m ON (b.member_id = m.id)
WHERE first_name = 'David' AND surname = 'Farrell';

(34 rows)

Produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.
Hint: In the WHERE clause use BETWEEN and specify the date (with time as HR:MN:SC).

SELECT start_time, name
FROM bookings b JOIN facilities f ON (b.facility_id = f.id)
WHERE name LIKE '%Tennis Court%' AND start_time BETWEEN '2012-09-21 00:00:01' AND '2012-09-21 23:59:59';

Produce a list of all members who have used a tennis court? Include in your output the name of the court, and the name of the member formatted as first name, surname. Ensure no duplicate data, and order by the first name.

Hint: This will require two JOINs
Example:
  FROM
    ... ...
      JOIN ... ...
         ON ... = ...
      JOIN ... ...
         ON ... = ...
  WHERE
    ... IN ...

SELECT DISTINCT m.first_name, m.surname, f.name
FROM members m JOIN bookings b ON (m.id = b.member_id)
JOIN facilities f ON (b.facility_id = f.id)
WHERE f.name LIKE '%Tennis Court%';


Produce a number of how many times Nancy Dare has used the pool table facility?

Hint: Two JOINs
WITH visits AS (
  SELECT
    m.first_name as first_name,
    m.surname as surname,
    f.name as name,
    m.id as id
  FROM members m
  JOIN bookings b ON (m.id = b.member_id)
  JOIN facilities f ON (b.facility_id = f.id)
  WHERE m.id = 7 AND f.id = 8
)
SELECT
  v.first_name, v.surname, v.name, COUNT(v.name) as times_visited
FROM visits v
GROUP BY v.first_name, v.surname, v.name;


Produce a list of how many times Nancy Dare has visited each country club facility.

Hint: Two JOINs


Produce a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

Hint: SELF JOIN The tables we are joining don't have to be different tables. We can join a table with itself. This is called a self join. In this case we have to use aliases for the table otherwise PostgreSQL will not know which id column of which table instance we mean.
Example:
FROM tacos ...
    JOIN tacos ...
      ON ... = ...


Output a list of all members, including the individual who recommended them (if any), without using any JOINs? Ensure that there are no duplicates in the list, and that member is formatted as one column and ordered by member.

Hint: To concatenate two columns to look like one you can use the ||
Example: SELECT DISTINCT ... || ' ' || ... AS ...,
Hint: See Subqueries Here and Here
Example:
SELECT DISTINCT ... || ' ' ||  ... AS ....,
    (SELECT ... || ' ' || ... AS ....
        FROM ... ...
        WHERE ... = ...
    ) FROM ... ...


Data licensed under https://creativecommons.org/licenses/by-sa/3.0/
