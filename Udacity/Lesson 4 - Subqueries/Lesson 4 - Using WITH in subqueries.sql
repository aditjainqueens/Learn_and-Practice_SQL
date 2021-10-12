/*1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
WITH total_acct_usd AS (SELECT s.name sales_rep_name,
							r.name region_name,
							SUM(o.total_amt_usd) total_amt
						FROM orders o
						JOIN accounts a
						ON o.account_id = a.id
						JOIN sales_reps s
						ON s.id = a.sales_rep_id
						JOIN region r
						ON r.id = s.region_id
						GROUP BY 1,2
						ORDER BY 3 DESC),

		max_amt AS (SELECT region_name, MAX(total_amt) max_total
					FROM total_acct_usd
					GROUP BY 1
					ORDER BY 2)

SELECT t.sales_rep_name, m.region_name, m.max_total
FROM max_amt m
JOIN total_acct_usd t
ON m.region_name = t.region_name AND m.max_total = t.total_amt

/*2. For the region with the largest sales total_amt_usd, how many total orders were placed?*/
WITH num_orders AS (SELECT r.name region_name, COUNT(o.total) total_ord, SUM(o.total_amt_usd) total_amt
				   FROM orders o
				   JOIN accounts a
				   ON o.account_id = a.id
				   JOIN sales_reps s
				   ON s.id = a.sales_rep_id
				   JOIN region r
				   ON r.id = s.region_id
				   GROUP BY 1)

SELECT region_name, total_ord
FROM num_orders
ORDER BY total_amt DESC
LIMIT 1

/*3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?*/
WITH sub AS (SELECT a.name account_name, SUM(o.standard_qty) total_std_qty, SUM(o.total) total
			 FROM accounts a
			 JOIN orders o
			 oN a.id = o.account_id
			 GROUP BY 1
			 ORDER BY 2 DESC
			 LIMIT 1),

	x AS (SELECT a.name, SUM(total) total_qty
		  FROM orders o
		  JOIN accounts a
		  ON a.id = o.account_id
		  GROUP BY 1
		  HAVING SUM(total) > (SELECT total
							   FROM sub)
		 )

SELECT COUNT(*)
FROM x

/*4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/
WITH t1 AS (SELECT a.name account_name, SUM(o.total_amt_usd) sum_total
			 FROM orders o
			 JOIN accounts a
			 ON a.id = o.account_id
			 GROUP BY 1
			 ORDER BY 2 DESC
			 LIMIT 1),

	  t2 AS (SELECT a.name account_name, w.channel, COUNT(*) num_events
			 FROM web_events w
			 JOIN accounts a
			 ON a.id = w.account_id
			 GROUP BY 1,2)

SELECT t1.account_name, t2.channel, t2.num_events
FROM t1
JOIN t2
ON t1.account_name = t2.account_name
ORDER BY 3 DESC

/*Alternative solution*/
WITH t1 AS (
   SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id
   GROUP BY a.id, a.name
   ORDER BY 3 DESC
   LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;


/*5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/
WITH sum_table AS (SELECT a.name, o.account_id, SUM(o.total_amt_usd) sum_amt
				   FROM orders o
				   JOIN accounts a
				   ON o.account_id = a.id
				   GROUP BY 1,2
				   ORDER BY 3 DESC
				   LIMIT 10)

SELECT AVG(sum_amt)
FROM sum_table

/*6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*/
WITH t1 AS (
   SELECT AVG(o.total_amt_usd) avg_all
   FROM orders o
   JOIN accounts a
   ON a.id = o.account_id),
t2 AS (
   SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
   FROM orders o
   GROUP BY 1
   HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))
SELECT AVG(avg_amt)
FROM t2;
