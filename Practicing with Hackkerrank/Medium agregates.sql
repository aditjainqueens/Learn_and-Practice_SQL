/*A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.*/
SELECT ROUND(lat_n,4)
FROM (Select *, Row_Number() Over (Order By lat_n) As RowNum
    FROM station
    ORDER BY lat_n DESC
     ) t2

WHERE RowNum = Round((Select
      Row_Number() Over (Order By lat_n) As RowNum
    FROM station
    ORDER BY lat_n DESC
    LIMIT 1)/2)

/*Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle. WHICH is when the sum of 2 sides are not larger than the other side*/
SELECT CASE WHEN A+B > C AND A+C > B AND B+C > A THEN
                CASE WHEN A = B AND A = C THEN 'Equilateral'
                    WHEN A = B OR A = C OR B = C THEN 'Isosceles'
                    WHEN (A != B AND A!= C AND B != C) THEN 'Scalene' END
            ELSE 'Not A Triangle' END AS shape
FROM triangles

/*Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).*/
SELECT CONCAT(name,'(',LEFT(occupation,1),')')
FROM occupations
ORDER BY name;

SELECT CONCAT('There are a total of ', COUNT(*),' ',LOWER(occupation),'s.')
FROM occupations
GROUP BY occupation
Order by COUNT(*), occupation

/*You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.



Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/
SELECT n,
        CASE WHEN p IS NULL THEN 'Root'
             WHEN n IN (SELECT p FROM bst) THEN 'Inner'
             ELSE 'Leaf'
             END AS node_type
FROM bst
ORDER BY n
