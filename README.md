# Introduction : 



Ce projet vise à explorer le marché de l'emploi Data Analyst à partir des données stockées dans PostgreSQL.



L’objectif est de répondre aux questions : 

    1- Quels sont les postes Data Analyst les mieux payés.

    2- Quelles sont compétences demandées pour ces postes.

    3- Quelles sont les compétences les PLUS demandées.

    4- Quelles sont les compétences les mieux remunérées.

    5- Quelles sont les compétences optimales combinant demande et salaire.


Remarque : L'analyse cible les postes Data Analyste en Remote !


# Structure de projet :

```pgsql
    projet_sql/
    │
    ├── 1_emplois_mieux_payes.sql
    ├── 2_competences_demplois.sql
    ├── 3_competences_plus_demandees.sql
    ├── 4_competences_mieux_payees.sql
    ├── 5_competences_optimales.sql
    │
    └── sql_load/
        ├── 1_create_database.sql
        ├── 2_create_tables.sql
        └── 3_modify_tables.sql
```

# Outils utilisés :

PostgreSQL / VS Code / Power BI (Visualisations)

# Analyses SQL

Il convient de noter que la modalité 'Anywhere' pour la variable job_location de la table job_postings_fact indique que le poste concerné est en Remote.

### Quels sont les postes Data Analyst les mieux rénumérés


```sql
SELECT c.name as ENTREPRISE , j.job_title_short AS POSTE, j.job_via AS SITE_RECTUREMENT, j.salary_year_avg AS SALAIRE_ANNUEL
FROM job_postings_fact as j
LEFT JOIN company_dim as c
ON j.company_id = c.company_id
WHERE j.salary_year_avg IS NOT NULL AND j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere'
ORDER BY salary_year_avg DESC;
```

La requête effectue une jointure (LEFT JOIN) entre la table job_postings_fact et la table company_id pour but d'afficher les noms d'entreprises. 

Après sauvegarde de la base de données de sortie, on sert de PowerBI pour visualiser les top 5 entreprises rénumérant le plus.



![<img width="1559" height="884" alt="1" src="https://github.com/user-attachments/assets/84b4b1ad-97ab-4201-814d-1744dcb8d335" />
]


### Quelles sont compétences démandées pour ces postes

Pour répondre à cette question, on pense à exploiter la requête précédente en la mettant comme CET (Common Table Expression) avant d'effectuer les jointures entre le résultat (précédent) et les tables skills_job_dim et skills_dim.

```SQL

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
```


### Quelles sont les compétences les PLUS demandées?

Il faut d'abord comprendre que la différence entre cette question et celle d'avant, est que, on essaye de tirer les compétences les plus demandées au lieux de lister toutes les compétences qu'apparaissent pour chaque offre. De cela, on utilise une aggregation (COUNT) et on regroupe par compétence (GROUP BY s.skills)

```sql
SELECT 
        s.skills AS Competences,
        COUNT(sk.job_id) as demande

FROM job_postings_fact as j



INNER JOIN skills_job_dim as sk ON j.job_id = sk.job_id

INNER JOIN skills_dim as s ON sk.skill_id = s.skill_id

WHERE  j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere'

GROUP BY s.skills


ORDER BY demande DESC;
```

La visualisation par PowerBI nous permet d'afficher la pie chart suivantes : 

INSERT HERE


Donc, SQL/Excel/Python/Tableau/PowerBI sont les plus exigées !

### Quelles sont les compétences les mieux rémunérées?




```sql
SELECT 

    AVG(j.salary_year_avg)::NUMERIC(6,0) AS SALAIRE_ANNUEL, 
    s.skills AS Competences



FROM job_postings_fact as j


INNER JOIN skills_job_dim as sk ON j.job_id = sk.job_id

INNER JOIN skills_dim as s ON sk.skill_id = s.skill_id


WHERE j.salary_year_avg IS NOT NULL AND j.job_title_short = 'Data Analyst' AND j.job_location = 'Anywhere'


GROUP BY competences

ORDER BY SALAIRE_ANNUEL DESC

;
```



### Quelles sont les compétences optimales ?


````sql

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
```
