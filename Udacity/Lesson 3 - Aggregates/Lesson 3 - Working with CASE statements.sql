/* Learning how CASE statement works*/

/* Example
Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order.
 Limit the results to the first 10 orders, and include the id and account_id fields.
*/

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders; /*This one generates an error because there are divisions by 0*/

/*The CASE statement Elimminates this error by allowing you give a value to the error*/
SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders;

/*Other ways to apply the CASE with an aggregate*/
SELECT CASE WHEN total > 500 THEN 'Over 500'
		ELSE '500 or under' END AS total_group,
		COUNT(*) AS order_count
FROM orders
GROUP BY 1;
