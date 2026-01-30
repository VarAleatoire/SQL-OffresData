
/*   

Objectif 5 : Renvoyer les compétences optimales. Càd : les plus demandées et les plus payées.

*/



SELECT 
        AVG(j.salary_year_avg)::NUMERIC(6,0) AS SALAIRE_ANNUEL, 
        s.skills AS Competences,
        COUNT(sk.job_id) as demande

FROM job_postings_fact as j



INNER JOIN skills_job_dim as sk ON j.job_id = sk.job_id

INNER JOIN skills_dim as s ON sk.skill_id = s.skill_id

WHERE  j.salary_year_avg IS NOT NULL AND j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere' 


GROUP BY s.skills

HAVING  COUNT(sk.job_id) > 10

ORDER BY SALAIRE_ANNUEL DESC, demande DESC;