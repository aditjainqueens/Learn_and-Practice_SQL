/*1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.*/
WITH total_acct_usd AS (SELECT a.name account_name,
							s.name sales_rep_name,
							s.id sales_rep_id,
							r.name region_name,
							SUM(o.total_amt_usd) total_amt
						FROM orders o
						JOIN accounts a
						ON o.account_id = a.id
						JOIN sales_reps s
						ON s.id = a.sales_rep_id
						JOIN region r
						ON r.id = s.region_id
						GROUP BY 1,2,3,4
						ORDER BY 5 DESC),

		max_amt AS (SELECT region_name, MAX(total_amt) max_total
					FROM total_acct_usd
					GROUP BY 1
					ORDER BY 2)

SELECT t.sales_rep_name, m.region_name, m.max_total
FROM max_amt m
JOIN total_acct_usd t
ON m.max_total = t.total_amt
