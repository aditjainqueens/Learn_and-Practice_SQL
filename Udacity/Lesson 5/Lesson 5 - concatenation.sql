/*How to use concatenations*/

/*Using CONCAT*/
WITH names AS (SELECT LEFT(name, STRPOS(name, ' ')-1) first_name,
			   			RIGHT(name, LENGTH(name)-STRPOS(name,' ')) last_name
			   FROM sales_reps)

SELECT CONCAT(first_name,' ',last_name)
FROM names

/*Using Piping*/
WITH names AS (SELECT LEFT(name, STRPOS(name, ' ')-1) first_name,
			   			RIGHT(name, LENGTH(name)-STRPOS(name,' ')) last_name
			   FROM sales_reps)

SELECT first_name||' '||last_name
FROM names

/* QUIZ*/

/*1.Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/
WITH poc_names AS (SELECT name, primary_poc,
            LEFT(LOWER(primary_poc), STRPOS(primary_poc,' ')-1) first_name,
			   		RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - STRPOS(primary_poc,' ')) last_name
			   FROM accounts)

SELECT first_name, last_name, first_name||'.'||last_name||'@'||name||'.com' email_address
FROM poc_names



/*2.You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1.*/
WITH poc_names AS (SELECT name, LEFT(LOWER(primary_poc), STRPOS(primary_poc,' ')-1) first_name,
				   		RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - STRPOS(primary_poc,' ')) last_name,
				   		REPLACE(LOWER(name),' ','') comp_name
				   FROM accounts)


SELECT first_name||'.'||last_name||'@'||comp_name||'.com' email_address
FROM poc_names n

/*3. We would also like to create an initial password, which they will change after their first log in.
The first password will be the first letter of the primary_poc's first name (lowercase),
then the last letter of their first name (lowercase),
the first letter of their last name (lowercase),
the last letter of their last name (lowercase),
the number of letters in their first name,
the number of letters in their last name,
and then the name of the company they are working with, all capitalized with no spaces.*/
WITH poc_names AS (SELECT name,
				   		LEFT(LOWER(primary_poc),STRPOS(primary_poc,' ')-1) first_name,
				   		RIGHT(LOWER(primary_poc),LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
				   FROM accounts)

SELECT first_name, last_name, LEFT(first_name,1)||RIGHT(first_name,1)||RIGHT(last_name,1)||LENGTH(first_name)||LENGTH(last_name)||REPLACE(UPPER(name),' ','') name_pass
FROM poc_names
