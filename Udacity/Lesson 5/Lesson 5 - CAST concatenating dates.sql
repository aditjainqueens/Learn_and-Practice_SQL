/*Write a query to change the date into the correct SQL date format. You will need to use at least SUBSTR and CONCAT to perform this operation.
Once you have created a column in the correct format use either CAST or :: to convert this to a date*/

SELECT date orig_date,
      (SUBSTR(date,7,4)||'-'||LEFT(date,2)||'-'||SUBSTR(date,4,2))::DATE new_date
FROM sf_crime_data;

/*the :: or CAST is used to convert from one data type to the other.
the syntax for CAST statement is

CAST(date_column AS DATE)

OR

date_column :: DATE
DATE_PART('month', TO_DATE(month, 'month')) here changed a month name into the number associated with that particular month.
*/
