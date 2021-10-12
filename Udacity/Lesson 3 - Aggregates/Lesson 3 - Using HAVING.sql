/* USING HAVING*/
SELECT  account_id,
		SUM(total_amt_usd) AS sum_total_amt_usd
FROM orders
GROUP BY 1
HAVING SUM(total_amt_usd) >= 250000

/* HAVING QUIZ
1. How many of the sales reps have more than 5 accounts that they manage?

2. How many accounts have more than 20 orders?

3. Which account has the most orders?

4. Which accounts spent more than 30,000 usd total across all orders?

5. Which accounts spent less than 1,000 usd total across all orders?

6. Which account has spent the most with us?

7. Which account has spent the least with us?

8. Which accounts used facebook as a channel to contact customers more than 6 times?

9. Which account used facebook most as a channel?

10. Which channel was most frequently used by most accounts?
*/

/*1. my answer*/
SELECT  sales_rep_id,
		COUNT(id) num_acct
FROM accounts
GROUP BY sales_rep_id
HAVING COUNT(id) > 5;
/*1. their answer*/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;


/*2. my answer */
SELECT  account_id,
		COUNT(*)
FROM orders
GROUP BY account_id
HAVING COUNT(*) > 20;
/*2. their answer*/
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;


/*3. my answer*/
SELECT  account_id,
		COUNT(*)
FROM orders
GROUP BY account_id
ORDER BY count DESC
LIMIT 1;
/*3. their answer*/
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1


/*4. my answer*/
SELECT  account_id,
		SUM(total_amt_usd)
FROM orders
GROUP BY account_id
HAVING SUM(total_amt_usd) > 30000;
/*4. their answer*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

/*5. my answer*/
SELECT  account_id,
		SUM(total_amt_usd)
FROM orders
GROUP BY account_id
HAVING SUM(total_amt_usd) < 1000;
/*their answer*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;


/*6. my answer*/
SELECT  account_id,
		SUM(total_amt_usd)
FROM orders
GROUP BY account_id
ORDER BY sum DESC
LIMIT 1;
/*their answer*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;


/*7. my answer*/
SELECT  account_id,
		SUM(total_amt_usd)
FROM orders
GROUP BY account_id
ORDER BY sum
LIMIT 1;
/*their answer*/
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;


/*8. my answer */
SELECT account_id, COUNT(channel)
FROM web_events
GROUP BY account_id, channel
HAVING channel = 'facebook' AND COUNT(channel) > 6;
/*their answer*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;


/*9. */
SELECT account_id, COUNT(channel)
FROM web_events
GROUP BY account_id, channel
HAVING channel = 'facebook'
ORDER BY count DESC
LIMIT 1;
/* their answer*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;


/*10. */
SELECT account_id, channel, COUNT(channel)
FROM web_events
GROUP BY account_id, channel
ORDER BY count DESC
LIMIT 1;
/* their answer*/
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;
