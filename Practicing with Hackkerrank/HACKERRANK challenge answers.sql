/*ANSWER FOR FULL SCORE HACKER QUEST*/
SELECT h.hacker_id, h.name
FROM submissions s
JOIN challenges c
ON c.challenge_id = s.challenge_id
JOIN difficulty d
ON d.difficulty_level = c.difficulty_level
JOIN hackers h
ON h.hacker_id = s.hacker_id
WHERE c.difficulty_level = d.difficulty_level AND d.score = s.score
GROUP BY 1,2
HAVING COUNT(s.challenge_id) > 1
ORDER BY COUNT(s.challenge_id) DESC,1


/*ANSWER FOR THE ASIAN POPULATION QUEST*/
SELECT SUM(city.population)
FROM city
JOIN country
ON city.countrycode = country.code
WHERE country.continent = 'Asia'

/*ANSWER FOR AVERAGE POPULATION OF EACH CONTINENT QUEST*/
SELECT country.continent, FLOOR(AVG(city.population))
FROM city
JOIN country
ON city.countrycode = country.code
GROUP BY 1


/*ANSWER FOR THE COMPANY QUEST*/
SELECT c.company_code, c.founder, COUNT(DISTINCT(e.lead_manager_code)) num_lead_man,COUNT(DISTINCT(e.senior_manager_code)) num_sen_man,COUNT(DISTINCT(e.manager_code)) num_man,COUNT(DISTINCT(e.employee_code)) num_emp
FROM company c
JOIN employee e
ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY company_code

/*ANSWER FOR THE REPORT QUEST ON HACKERRANK*/
SELECT CASE WHEN grade >= 8 THEN s.name ELSE 'NULL' END AS name, g.grade,s.marks
FROM students s
JOIN grades g
ON s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY 2 DESC,1


/*Answer to the challenges quest on hackerrank*/
SELECT h.hacker_id, h.name, COUNT(*)
FROM Hackers h
JOIN Challenges c
ON h.hacker_id =c.hacker_id
WHERE h.hacker_id NOT IN
(SELECT t1.hacker_id
 FROM (SELECT hacker_id, COUNT(*) as cnt
       FROM Challenges
       GROUP BY hacker_id) as t1
JOIN /*This is a self join to remove the multiple hacker id accounts with the same challenge number counts*/
(SELECT hacker_id, COUNT(*) as cnt
 FROM Challenges
 GROUP BY hacker_id) as t2
 ON t1.hacker_id != t2.hacker_id AND t1.cnt=t2.cnt AND t1.cnt != (SELECT COUNT(*)
                                                                  FROM Challenges
                                                                  GROUP BY hacker_id
                                                                  ORDER BY COUNT(*) DESC
                                                    LIMIT 1))
GROUP BY 1,2
ORDER BY COUNT(*) DESC, h.hacker_id
