/*aggregation and nulls

aggregators aggregate verticallin down the cloumn. To add across rows, use simple arithmetic.*/

/*
1. Find the total amount of poster_qty paper ordered in the orders table.

2. Find the total amount of standard_qty paper ordered in the orders table.

3. Find the total dollar amount of sales using the total_amt_usd in the orders table.

4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.

5. Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
*/

/*1. */ SELECT SUM(poster_qty) AS poster
FROM orders;

/*2. */ SELECT SUM(standard_qty) AS standard
FROM orders;

/*3. */ SELECT SUM(total_amt_usd) AS total
FROM orders

/*4. */ SELECT standard_amt_usd + gloss_amt_usd AS total
FROM orders;

/*5. */ SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS total
FROM orders;

/*
1. When was the earliest order ever placed? You only need to return the date.

2. Try performing the same query as in question 1 without using an aggregation function.

3. When did the most recent (latest) web_event occur?

4. Try to perform the result of the previous query without using an aggregation function.

5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
*/

/*1. */ SELECT MIN(occurred_at) as earliest_order
FROM orders;

/*2 */ SELECT occurred_at as earliest_order
FROM orders
ORDER BY occurred_at
LIMIT 1;

/*3. */ SELECT MAX(occurred_at) AS latest_event
FROM web_events;

/*4. */ SELECT occurred_at AS latest_event
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/*5. */ SELECT  AVG(standard_amt_usd) AS mean_std_amt,
		AVG(gloss_amt_usd) AS mean_gloss_amt,
		AVG(poster_amt_usd) AS mean_poster_amt,
		AVG(standard_qty) AS mean_std_qty,
		AVG(gloss_qty) AS mean_gloss_qty,
		AVG(poster_qty)AS mean_pst_qty
FROM orders;

/*6. answer provided by them*/ SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
