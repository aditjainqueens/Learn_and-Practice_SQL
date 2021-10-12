/*1. In the accounts table, there is a column holding the website for each company.
The last three digits specify what type of web address they are using
 A list of extensions (and pricing) is provided here.
 Pull these extensions and provide how many of each website type exist in the accounts table.*/

SELECT RIGHT(website,3) ext, COUNT(*)
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*2. There is much debate about how much the name (or even the first letter of a company name) matters.
Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).*/
SELECT LEFT(name,1) name_initial, COUNT(*)
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*3. Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter.
What proportion of company names start with a letter?*/
WITH t1 AS (SELECT CASE WHEN LEFT(name,1) BETWEEN '0' AND '9' THEN 'num_start'
						ELSE 'letter_start' END AS name_category,
					COUNT(*) num_cases
			FROM accounts
			GROUP BY 1)

SELECT name_category, num_cases * 100/(SELECT SUM(num_cases) total_sum
								 FROM t1) proportion
FROM t1

/*alternative solution provided*/
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 1 ELSE 0 END AS num,
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;

/*4. Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?*/
WITH t1 AS (SELECT CASE WHEN LEFT(UPPER(name),1) IN ('A','E','I','O','U') THEN 'vowel_start'
						ELSE 'other_start' END AS name_category,
					COUNT(*) num_cases
			FROM accounts
			GROUP BY 1)

SELECT name_category, num_cases * 100/(SELECT SUM(num_cases) total_sum
								 FROM t1) proportion
FROM t1
