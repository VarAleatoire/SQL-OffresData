

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




SELECT job_id, name AS entreprise, job_title, job_location,job_posted_date, job_schedule_type, salary_year_avg
FROM company_dim AS com
INNER JOIN CET AS ce
ON com.company_id = ce.company_Id
;


