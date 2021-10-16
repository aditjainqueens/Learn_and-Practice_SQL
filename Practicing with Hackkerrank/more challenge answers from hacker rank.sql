/*Answer to the contest leader board quest on hackerrank*/
SELECT hacker_id, name, SUM(max_score) sums
FROM (SELECT h.hacker_id, h.name, s.challenge_id, MAX(s.score) max_score
FROM hackers h
JOIN submissions s
ON h.hacker_id = s.hacker_id
GROUP BY 1,2,3) mn
GROUP BY 1,2
HAVING SUM(max_score) != 0
ORDER BY 3 DESC, 1
