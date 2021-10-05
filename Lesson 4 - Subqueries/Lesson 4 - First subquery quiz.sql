/*Writing my first subquery quiz*/
SELECT channel,
AVG(event_count) AS avg_event_count
FROM (
  SELECT DATE_TRUNC('day',occurred_at) AS day,
channel,
COUNT(*) AS event_count
FROM web_events
GROUP BY 1,2
  ) sub
GROUP BY 1

/* Use DATE_TRUNC to pull month level informattion about the first order ever placed in th eorders table*/
SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
 FROM orders;

/*Use the result of the previous query to find only the orders that took place in the same month and year as the first order and then pull the average for each type of paper quantity in this month*/
SELECT AVG(standard_qty) AS avg_std_qty,
		AVG(gloss_qty) AS avg_gloss_qty,
		AVG(poster_qty) AS avg_poster_qty
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
	 FROM orders) /*This subquery pulls the first year month combo*/

/*From the table gotten above, find:
The average amount of standard paper sold on the first month that any order was placed in the orders table (in terms of quantity).

The average amount of gloss paper sold on the first month that any order was placed in the orders table (in terms of quantity).

The average amount of poster paper sold on the first month that any order was placed in the orders table (in terms of quantity).

The total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd).
*/
SELECT AVG(standard_qty) AS avg_std_qty,
		AVG(gloss_qty) AS avg_gloss_qty,
		AVG(poster_qty) AS avg_poster_qty,
		SUM(total_amt_usd) AS total_amt_usd
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
	 FROM orders)
