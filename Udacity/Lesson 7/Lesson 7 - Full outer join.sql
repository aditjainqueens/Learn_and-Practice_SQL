/*Say you're an analyst at Parch & Posey and you want to see:

each account who has a sales rep and each sales rep that has an account (all of the columns in these returned rows will be full)
but also each account that does not have a sales rep and each sales rep that does not have an account (some of the columns in these returned rows will be empty)
This type of question is rare, but FULL OUTER JOIN is perfect for it. In the following SQL Explorer, write a query with FULL OUTER JOIN to fit the above described Parch & Posey scenario (selecting all of the columns in both of the relevant tables, accounts and sales_reps) then answer the subsequent multiple choice quiz.*/
SELECT a.id,
		s.name
FROM accounts a
FULL OUTER JOIN sales_reps s
ON a.sales_rep_id = s.id
