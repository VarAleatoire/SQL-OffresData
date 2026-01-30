/*   

Objectif 3 : Renvoyer les compétences les plus demandées (toujours pour Data Analyst en Remote)

*/



SELECT 
        s.skills AS Competences,
        COUNT(sk.job_id) as demande

FROM job_postings_fact as j



INNER JOIN skills_job_dim as sk ON j.job_id = sk.job_id

INNER JOIN skills_dim as s ON sk.skill_id = s.skill_id

WHERE  j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere'

GROUP BY s.skills


ORDER BY demande DESC;