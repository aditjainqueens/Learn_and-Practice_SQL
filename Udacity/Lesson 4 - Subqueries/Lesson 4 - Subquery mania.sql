/*1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales. */
SELECT rep_name, region_name, total_amt
FROM (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
			FROM orders o
			JOIN accounts a
			ON o.account_id = a.id
			JOIN sales_reps s
			ON s.id = a.sales_rep_id
			JOIN region r
			ON r.id = s.region_id
			GROUP BY 1,2
		) ss_sub
WHERE total_amt IN (SELECT total_amt
										FROM (SELECT region_name, MAX(sum) total_amt
													FROM (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd)
																FROM orders o
																JOIN accounts a
																ON o.account_id = a.id
																JOIN sales_reps s
																ON s.id = a.sales_rep_id
																JOIN region r
																ON r.id = s.region_id
																GROUP BY 1,2) sub
						  								GROUP BY 1) y
				   )

/*2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?*/
SELECT r.name, COUNT(*)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
JOIN (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
	  FROM orders o
	  JOIN accounts a
	  ON o.account_id = a.id
	  JOIN sales_reps s
	  ON s.id = a.sales_rep_id
	  JOIN region r
	  ON r.id = s.region_id
	  GROUP BY 1
	  LIMIT 1) b
ON b.region_name = r.name
GROUP BY 1


/*3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer*/
SELECT COUNT(*)
FROM (SELECT a.name, SUM(o.total) total_qty
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total
				   FROM (SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(total) total
						 FROM orders o
						 JOIN accounts a
						 ON o.account_id = a.id
						 GROUP BY 1
						 ORDER BY 2 DESC
						 LIMIT 1) b
				   JOIN accounts a
				   ON b.account_name = a.name)
	AND a.name NOT IN (SELECT account_name
						 FROM (SELECT a.name account_name,
							   		SUM(o.standard_qty) total_std
							   FROM orders o
							   JOIN accounts a
							   ON o.account_id = a.id
							   GROUP BY 1
							   ORDER BY 2 DESC
							   LIMIT 1) b
						 JOIN accounts a
						 ON b.account_name = a.name)
	  ) c

/*4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/
SELECT a.name, channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND account_id = (SELECT account_id
					FROM (SELECT w.account_id, SUM(total_amt_usd)
							FROM orders o
							JOIN web_events w
							ON w.account_id =o.account_id
							GROUP BY 1
							ORDER BY 2 DESC
							LIMIT 1) x
					)
GROUP BY 1,2
ORDER BY 3 DESC

/*5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?*/
SELECT AVG(tot_spent)
FROM (SELECT  a.id,
		a.name,
		SUM(total_amt_usd) tot_spent
	  FROM orders o
	  JOIN accounts a
	  ON a.id = o.account_id
	  GROUP BY 1,2
	  ORDER BY 3 DESC
	  LIMIT 10) sub;

/*6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.*/
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
    FROM orders o
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                   FROM orders o)) temp_table;
