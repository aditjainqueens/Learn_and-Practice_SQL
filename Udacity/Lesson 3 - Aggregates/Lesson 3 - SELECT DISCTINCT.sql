/*SELECT DISTINCT*/
SELECT DISTINCT account_id,
channel
FROM web_events
ORDER BY account_id

/*
1. Use DISTINCT to test if there are any accounts associated with more than one region.


2. Have any sales reps worked on more than one account?
*/

/*1. what  i did*/
SELECT DISTINCT a.id, r.name, COUNT(*)
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY a.id, r.name
ORDER BY count

/*1. the answer*/
SELECT a.id as "account id", r.id as "region id",
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;
/*comparing the number of rows with this part*/
SELECT DISTINCT id, name
FROM accounts;

/*2. what i did */
SELECT DISTINCT s.id, COUNT(a.id) count
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.id
ORDER BY count

/*2. the answer*/
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;
/*comparing with the number of rows in the next part*/
SELECT DISTINCT id, name
FROM sales_reps;
