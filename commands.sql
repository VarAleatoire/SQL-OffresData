SELECT COUNT(*)
FROM job_postings_fact  
WHERE job_location='Anywhere'
;



WITH remote AS (
    SELECT *
    FROM job_postings_fact  
    WHERE job_location='Anywhere'
    
)



SELECT  min(r.job_title_short), s.skills as capacite, COUNT(*) as total
FROM skills_job_dim AS sj 
INNER JOIN remote AS r
ON sj.job_id = r.job_id
INNER JOIN skills_dim AS s
ON sj.skill_id=s.skill_id
GROUP BY s.skills
ORDER BY total DESC
;