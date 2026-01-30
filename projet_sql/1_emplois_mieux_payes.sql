/*   

Objectif 1 : Renvoyer les postes Data Analyst en Remote. les mieux payés

*/





SELECT company_id, job_title_short, job_via, salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst' AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 4;



/*   Et si on aimerai affiché le nom de l'entreprise aussi ? 🧐 

*/


SELECT c.name as ENTREPRISE , j.job_title_short AS POSTE, j.job_via AS SITE_RECTUREMENT, j.salary_year_avg AS SALAIRE_ANNUEL
FROM job_postings_fact as j
LEFT JOIN company_dim as c
ON j.company_id = c.company_id
WHERE j.salary_year_avg IS NOT NULL AND j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere'
ORDER BY salary_year_avg DESC;