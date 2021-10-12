SELECT channel,
		AVG(event_count) AS avg_event_count
FROM(SELECT DATE_TRUNC('day', occurred_at) AS day, /* Subquery is nested within parentheses*/
		channel,
		COUNT(*) AS event_count
	 FROM web_events
	 GROUP BY 1,2
	 ORDER BY 3 DESC) sub /*Remember to give your subquery an alias*/
GROUP BY 1
ORDER BY 2 DESC;

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

/*Using subqueries in conditional statements*/
SELECT *
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
	 FROM orders)
ORDER BY occurred_at

/*Quiz 1*/
SELECT AVG(standard_qty) AS avg_std_qty,
		AVG(gloss_qty) AS avg_gloss_qty,
		AVG(poster_qty) AS avg_poster_qty
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
	 FROM orders)

/*Quiz 2*/
SELECT AVG(standard_qty) AS avg_std_qty,
		AVG(gloss_qty) AS avg_gloss_qty,
		AVG(poster_qty) AS avg_poster_qty,
		SUM(total_amt_usd) AS total_amt_usd
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
	(SELECT DATE_TRUNC('month',MIN(occurred_at)) AS min_month
	 FROM orders)
