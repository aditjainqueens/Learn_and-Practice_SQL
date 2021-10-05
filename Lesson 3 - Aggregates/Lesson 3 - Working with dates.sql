/*
1. Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

2. Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

3. Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

4. Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

5. In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
*/

/*1. */
SELECT  DATE_PART('year',occurred_at) AS year,
		SUM(total_amt_usd) AS total_amt_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC

/*2. */
SELECT  DATE_PART('month',occurred_at) AS month,
		SUM(total_amt_usd) AS total_amt_usd
FROM orders
GROUP BY 1
ORDER BY 2 DESC

/*3. */
SELECT  DATE_PART('year',occurred_at) AS year,
		SUM(total) AS total_qty
FROM orders
GROUP BY 1
ORDER BY 2 DESC

/*4. */
SELECT  DATE_PART('month',occurred_at) AS month,
		SUM(total) AS total_qty
FROM orders o
GROUP BY 1
ORDER BY 2 DESC

/*5. */
SELECT  DATE_PART('year',o.occurred_at) AS YEAR,
		DATE_PART('month',o.occurred_at) AS month,
		SUM(o.gloss_amt_usd) AS gloss_amt
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name, 1, 2
HAVING a.name = 'Walmart'
ORDER BY 3 DESC
LIMIT 1

/* ALTERNATIVE ANSWER*/
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
