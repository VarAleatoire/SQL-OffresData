/*   

Objectif 2 : Renvoyer les compétences demandées pour ces emplois précédents.

*/



WITH CET AS (
    SELECT job_id, job_title, 
            salary_year_avg,
            job_schedule_type,
            company_id,
            job_location,
            job_posted_date
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10


) 




SELECT DISTINCT(ce.job_id), name AS entreprise, sk.skills
        job_title, 
        job_location,
        job_posted_date, 
        job_schedule_type, 
        salary_year_avg

FROM company_dim AS com
INNER JOIN CET AS ce
ON com.company_id = ce.company_Id
INNER JOIN skills_job_dim as sj
ON sj.job_id = ce.job_id
INNER JOIN skills_dim as sk
ON sk.skill_id = sj.skill_id


;


