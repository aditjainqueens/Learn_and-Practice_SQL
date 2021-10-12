/*
1. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

4. Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

5. Who was the primary contact associated with the earliest web_event?

6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
*/

/*1. */
SELECT  o.occurred_at,
		a.name
FROM orders o
JOIN accounts a
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1

/*2. */
SELECT  a.name,
		SUM(o.total_amt_usd) total_sales_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name

/*3. */
SELECT  w.occurred_at,
		w.channel,
		a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1

/*4. */
SELECT channel,
		COUNT(channel) AS total_num
FROM web_events
GROUP BY channel

/*5. */
SELECT  a.primary_poc
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1

/*6.*/
SELECT  a.name,
		MIN(o.total_amt_usd) total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_usd

/*7. */
SELECT  r.name,
		COUNT(s.name) num_srep
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
GROUP BY r.name
ORDER BY num_srep

/* the group by clause*/
SELECT account_id, channel, COUNT(id) AS events
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id, events
