
-- Creating Table
CREATE TABLE `data`.`films` (
id	INT,
title VARCHAR(255),
release_year INT NULL,
country	VARCHAR(255),
duration INT NULL,
language VARCHAR(255),
certification VARCHAR(255),	
gross BIGINT NULL,
budget BIGINT NULL
);

--LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/films-a.csv"
INTO TABLE films 
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;    # I disabled this query by adding an extra hyphen so that the data won't be double input

SELECT * FROM data.films;

-- Begin Films Exploratory Data Analysis using SQL (Questions by Datacamp Intermediate Course)

-- Select Spanish or French language movie titles which are released in 1990-2000 with budget more than 100 millions
SELECT title, release_year
FROM films
WHERE (release_year BETWEEN 1990 AND 2000)
    AND (budget > 100000000)
    AND (language = 'Spanish' OR language = 'French'); 

-- Select Spanish or French language movie titles which are released in 1990-2000 with budget more than 100 millions
SELECT title, release_year
FROM films
WHERE (release_year BETWEEN 1990 AND 2000)
    AND (budget > 100000000)
    AND (language = 'Spanish' OR language = 'French'); 

-- Select the title that have r as the second letter
SELECT title
FROM films
WHERE title LIKE '_r%';

SELECT title
FROM films
-- Select title that don't start with A
WHERE title NOT LIKE 'A%';

-- Find the title, certification, and language all films certified NC-17 or R that are in English, Italian, or Greek
SELECT title, certification, language
FROM films
WHERE (certification IN ('NC-17', 'R')) AND (language IN ('English','Italian','Greek'));

-- Count the unique titles
SELECT COUNT(DISTINCT title) AS nineties_english_films_for_teens
FROM films
-- Filter to release_years to between 1990 and 1999
WHERE (release_year BETWEEN 1990 AND 1999)
-- Filter to English-language films
    AND (language = 'English')
-- Narrow it down to G, PG, and PG-13 certifications
    AND (certification IN ('G', 'PG', 'PG-13'));

-- Query the sum of film durations
SELECT SUM(duration) AS total_duration
FROM films;

-- Find the latest release_year
SELECT MAX(release_year) AS latest_year
FROM films;

-- Calculate the sum of gross from the year 2000 or later
SELECT SUM(gross) AS total_gross
FROM films 
WHERE release_year >= 2000;

-- Calculate the average gross of films that start with A
SELECT AVG(gross) AS avg_gross_A
FROM films
WHERE title LIKE 'A%';

-- Calculate the lowest gross film in 1994
SELECT MIN(gross) AS lowest_gross
FROM films
WHERE release_year = 1994;

-- Calculate the highest gross film released between 2000-2012
SELECT MAX(gross) AS highest_gross
FROM films
WHERE release_year BETWEEN 2000 AND 2012;

-- Round the average number of facebook_likes to one decimal place
SELECT ROUND(AVG(facebook_likes), 1) AS avg_facebook_likes
FROM reviews;

-- Calculate the average budget rounded to the thousands
SELECT ROUND(AVG(budget), -3) AS avg_budget_thousands
FROM films;

-- Calculate the title and duration_hours from films
SELECT title, (duration / 60) AS duration_hours
FROM films;

-- Calculate the percentage of people who are no longer alive
SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead
FROM people;

-- Find the number of decades in the films table
SELECT (MAX(release_year)-MIN(release_year)) / 10.0 AS number_of_decades
FROM films;

-- Round duration_hours to two decimal places
SELECT title, ROUND((duration / 60.0), 2) AS duration_hours
FROM films;

-- Select the title and duration from longest to shortest film
SELECT title, duration
FROM films
WHERE duration IS NOT NULL
ORDER BY duration DESC;

-- Select the release year, duration, and title sorted by release year and duration
SELECT release_year, duration, title
FROM films
ORDER BY release_year, duration

-- Select the certification, release year, and title sorted by certification and most recent release year
SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year DESC;

-- Find the release_year and film_count of each year
SELECT release_year, COUNT(*) AS film_count
FROM films
GROUP BY release_year;

-- Find the release_year and average duration of films for each year
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;

-- Find the release_year, country, and max_budget, then group and order by release_year and country
SELECT release_year, country, MAX(budget) AS max_budget
FROM films
GROUP BY release_year, country

-- Which release_year had the most language diversity?
SELECT release_year, COUNT(DISTINCT language) AS num_of_languages
FROM films
GROUP BY release_year
ORDER BY num_of_languages DESC;

-- Find out which countries (or country) have the most varied film certifications.
SELECT country, COUNT(DISTINCT certification) AS certification_count
FROM films
GROUP BY country
HAVING COUNT(DISTINCT certification) > 10;

-- Filter to the most countries with an average_budget of more than one billion
SELECT country, ROUND(AVG(budget), 2) AS average_budget
FROM films
GROUP BY country
HAVING AVG(budget) > 1000000000
ORDER BY average_budget DESC

-- Select the budget for films released after 1990 grouped by year
SELECT release_year
FROM films
GROUP BY release_year
HAVING release_year > 1990;

--Calculate average budget and gross earnings for films each year after 1990 if the average budget is greater than 60 million
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY avg_gross DESC
LIMIT 1;