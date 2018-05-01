
Country Database Join Challenge
Start by making a picture showing the tables of the database and how the relate (which columns represent the same information).

Relatively Simple JOINS
What languages are spoken in the United States? (12) Brazil? (not Spanish...) Switzerland? (6)
SELECT
cl.language AS US_LANGUAGES
FROM country c
JOIN countrylanguage cl
ON (c.code = cl.countrycode)
WHERE code = 'USA'

SELECT
cl.language AS US_LANGUAGES
FROM country c
JOIN countrylanguage cl
ON (c.code = cl.countrycode)
WHERE code = 'BRA'

SELECT
cl.language AS US_LANGUAGES,
cl.countrycode
FROM country c
JOIN countrylanguage cl
ON (c.code = cl.countrycode)
WHERE code = 'CHE'

What are the cities of the US? (274) India? (341)
SELECT name FROM city WHERE countrycode = 'USA'

SELECT name FROM city WHERE countrycode = 'IND'

Languages
What are the official languages of Switzerland? (4 languages)
SELECT
countrycode,
language,
isofficial
FROM countrylanguage
WHERE countrycode = 'CHE' AND isofficial = true

Which country or countries speak the most languages? (12 languages)
Hint: Use GROUP BY and COUNT(...)
SELECT COUNT(language), countrycode
FROM countrylanguage
GROUP BY countrycode
ORDER BY COUNT (language) DESC

Which country or countries have the most official languages? (4 languages)
Hint: Use GROUP BY and ORDER BY
SELECT COUNT(language), countrycode, name
FROM country c
JOIN countrylanguage cl
ON (c.code = cl.countrycode)
WHERE isofficial = true
GROUP BY countrycode, name
ORDER BY COUNT (language) DESC;

Which languages are spoken in the ten largest (area) countries?
Hint: Use WITH to get the countries and join with that table

WITH largest_countries AS
(SELECT name, surfacearea, code
FROM country
WHERE population >0
ORDER BY surfacearea DESC LIMIT 10)
SELECT cl.language, lc.name
FROM largest_countries lc JOIN countrylanguage cl ON (lc.code = cl.countrycode)
ORDER BY lc.name;


What languages are spoken in the 20 poorest (GNP/ capita) countries in the world? (94 with GNP > 0)
Hint: Use WITH to get the countries, and SELECT DISTINCT to remove duplicates
WITH poorest_countries AS(
SELECT code, name, gnp / population AS capita
FROM country
WHERE population >0 AND gnp >0
ORDER BY capita ASC LIMIT 20)

SELECT DISTINCT cl.language --, pc.name, pc.capita
FROM countrylanguage cl
JOIN poorest_countries pc ON (cl.countrycode = pc.code)
ORDER BY cl.language

Are there any countries without an official language?
Hint: Use NOT IN with a SELECT

SELECT name
FROM country
WHERE code NOT IN (SELECT countrycode FROM countrylanguage WHERE isofficial = true)

What are the languages spoken in the countries with no official language? (49 countries, 172 languages, incl. English)



Which countries have the highest proportion of official language speakers? The lowest?
What is the most spoken language in the world?
Cities
What is the population of the United States? What is the city population of the United States?
What is the population of the India? What is the city population of the India?
Which countries have no cities? (7 not really contries...)
Languages and Cities
What is the total population of cities where English is the official language? Spanish?
Hint: The official language of a city is based on country.
Which countries have the 100 biggest cities in the world?
What languages are spoken in the countries with the 100 biggest cities in the world?
