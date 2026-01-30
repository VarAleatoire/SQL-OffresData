 NOTE: This has been updated from the video to fix issues with encoding

COPY company_dim
FROM '/Users/mac/Sql_Project/csv_files/company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM '/Users/mac/Sql_Project/csv_files/skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM '/Users/mac/Sql_Project/csv_files/job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM '/Users/mac/Sql_Project/csv_files/skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
