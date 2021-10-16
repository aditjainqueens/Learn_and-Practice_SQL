/*Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.*/
SELECT ROUND(lat_n,4) as roundvalue /*Rounds the number to 4 decimal places*/
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1

/*Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.*/
SELECT ROUND(long_w,4) as roundvalue
FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1

/*Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.

 a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1 and P2 and round it to a scale of  decimal places.*/
SELECT ROUND(ABS(MIN(lat_n)-MAX(lat_n)) + ABS(MIN(long_w)-MAX(long_w)),4)
FROM station

/*Query a count of the number of cities in CITY having a Population larger than 100000.*/
SELECT COUNT(*)
FROM city
WHERE population > 100000

/*Query the total population of all cities in CITY where District is California.*/
SELECT SUM(population)
FROM city
WHERE district = 'California'

/*Query the average population of all cities in CITY where District is California.*/
SELECT AVG(population)
FROM city
WHERE district = 'California'

/*Query the average population for all cities in CITY, rounded down to the nearest integer.*/
SELECT FLOOR(AVG(population))
FROM city

/*Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN*/
SELECT SUM(population)
FROM city
WHERE countrycode = 'JPN'

/*Query the difference between the maximum and minimum populations in CITY.*/
SELECT MAX(population) - MIN(population)
FROM city

/*Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.*/
SELECT CEILING(AVG(salary) - AVG(CAST(REPLACE(CAST(salary AS char),'0','') AS UNSIGNED)))
FROM employees

/*We define an employee's total earnings to be their monthly salary * months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.*/
SELECT months * salary earnings, COUNT(*)
FROM employee
WHERE months*salary = (SELECT MAX(months*salary)
                        FROM employee)
GROUP BY 1

/*Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.*/
SELECT ROUND(SUM(lat_n),2),ROUND(SUM(long_w),2)
FROM station

/*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 2 decimal places.*/
SELECT ROUND(SUM(lat_n),4)
FROM station
WHERE lat_n > 38.7880 AND lat_n < 137.2345

/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places.*/
SELECT ROUND(MAX(lat_n),4)
FROM station
WHERE lat_n < 137.2345

/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.*/
SELECT ROUND(long_w,4)
FROM station
WHERE lat_n < 137.2345
ORDER BY lat_n DESC
LIMIT 1

/*Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points  and  and format your answer to display 4 decimal digits.*/
SELECT ROUND(SQRT(POWER(MAX(lat_n)-MIN(lat_n),2) + POWER(MAX(long_w)-MIN(long_w),2)),4)
FROM station
