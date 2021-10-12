
/*
1. For each account, determine the average amount of each type of paper they purchased across their orders.
Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

2. For each account, determine the average amount spent per order on each paper type.
Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

3. Determine the number of times a particular channel was used in the web_events table for each sales rep.
Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences.
Order your table with the highest number of occurrences first.

4. Determine the number of times a particular channel was used in the web_events table for each region.
Your final table should have three columns - the region name, the channel, and the number of occurrences.
Order your table with the highest number of occurrences first.
*/

/*1. */
SELECT  a.name,
		AVG(o.standard_qty) mean_std,
		AVG(o.poster_qty) mean_poster,
		AVG(o.gloss_qty) mean_glossy
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name

/*2. */
SELECT  a.name,
		AVG(o.standard_amt_usd) mean_std_amt,
		AVG(o.poster_amt_usd) mean_poster_amt,
		AVG(o.gloss_amt_usd) mean_glossy_amt
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name

/*3. */
SELECT  s.name,
		w.channel,
		COUNT(*) chan_num
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON w.account_id = a.id
GROUP BY s.name, w.channel
ORDER BY chan_num DESC

/*4. */
SELECT  r.name,
		w.channel,
		COUNT(*) chan_num
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON w.account_id =a.id
GROUP BY r.name, w.channel
ORDER BY chan_num DESC
