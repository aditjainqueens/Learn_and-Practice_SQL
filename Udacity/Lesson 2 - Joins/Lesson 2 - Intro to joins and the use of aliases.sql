/*
Practicing JOIN
*/

SELECT * /* this query allows you pull all the data from both the accounts table and the orders table*/
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;


SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

/*
the use of aliases


you can just leave a space after the table.columnname and put the alias there.

you then change the name in the from and join clauses
*/

/*
1. Provide a table for all web_events associated with account name of Walmart.
There should be three columns.
Be sure to include the primary_poc, time of the event, and the channel for each event.
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
*/

SELECT wbe.occurred_at, wbe.channel, acc.primary_poc, acc.name
FROM web_events wbe
JOIN accounts acc
ON wbe.account_id = acc.id
WHERE name IN ('Walmart');

/*
2. Provide a table that provides the region for each sales_rep along with their associated accounts.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.
*/

SELECT reg.name region_name, srep.name sales_rep_name, acc.name account_name
FROM region reg
JOIN sales_reps srep
ON srep.region_id = reg.id
JOIN accounts acc
ON srep.id = acc.sales_rep_id
ORDER BY acc.name;

/*
3. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
Your final table should have 3 columns: region name, account name, and unit price.
A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
*/

SELECT reg.name region_name,
	   acc.name account_name,
	   (ord.total_amt_usd/(ord.total+0.01)) AS unit_price
FROM region reg
JOIN sales_reps srep
ON reg.id = srep.region_id
JOIN accounts acc
ON srep.id  = acc.sales_rep_id
JOIN orders ord
ON acc.id = ord.account_id;
