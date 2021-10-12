/*
1. Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.

2. Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

3. When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not?
Figure out the answer to this important question by writing a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.

4. Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords channels,
 and started their account at any point in 2016, sorted from newest to oldest.
 */

/*1. */
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/*2. */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/*3. */
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/*4.  */
SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

SELECT account_id,
occurred_at,
standard_qty,
gloss_qty,
poster_qty
FROM orders
WHERE (standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0)
AND occurred_at >= '2016-10-01' ;
