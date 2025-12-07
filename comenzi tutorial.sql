SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
limit 5;

SELECT * FROM job_postings_fact
LIMIT 100;

SELECT 
    job_title_short,
    AVG(salary_year_avg) AS average_salary,
 
    --job_posted_date :: DATE AS date
FROM job_postings_fact
where job_posted_date > '2023-06-01'
GROUP BY job_title_short --date
-- HAVING salary_rate in ('hour', 'year')
limit 100;

CREATE TABLE january_jobs AS
    SELECT* FROM job_postings_fact
    WHERE EXTRACT (month from job_posted_date) =1;

CREATE TABLE february_jobs AS
    SELECT* FROM job_postings_fact
    WHERE EXTRACT (month from job_posted_date) =2;

CREATE TABLE march_jobs AS
    SELECT* FROM job_postings_fact
    WHERE EXTRACT (month from job_posted_date) =3;

DROP table january_jobs;
drop table february_jobs
drop table march_jobs;

SELECT * FROM january_jobs
LIMIT 10;

*/
--- >500 000 = high paying jobs
--- betwewen 300 000 and 500 000 = medium paying jobs
--- < 300 000 = low paying jobs
*/

SELECT 
job_title_short,
salary_year_avg,
job_location,
CASE
    WHEN salary_year_avg > 500000 THEN 'high paying job'
    WHEN salary_year_avg BETWEEN 300000 AND 500000 THEN 'medium paying job'
    ELSE 'low paying job'
END AS salary_category
FROM job_postings_fact
WHERE NOT salary_year_avg IS NULL AND job_title_short LIKE 'Data Analyst%'
Order BY salary_year_avg DESC


LIMIT 100;


WITH high_salary_jobs AS (
    SELECT salary_year_avg
    FROM job_postings_fact
    WHERE salary_year_avg > 700000
)
SELECT *
FROM high_salary_jobs
LIMIT 100;



    SELECT *
    
    from job_postings_fact
    
    limit 100;


WITH counted_skills AS (
 SELECT 
 skill_id,
 COUNT(*)
    
    from skills_job_dim
    group by skill_id
)

SELECT skills_dim.skills, count, counted_skills.skill_id
from counted_skills
left join skills_dim ON skills_dim.skill_id = counted_skills.skill_id
ORDER BY count DESC
limit 5;

-- if <10 job postings = small
-- if between 10 and 50 job postings = medium
-- if >50 job postings = large


    SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
     FROM (SELECT * FROM january_jobs
    UNION
    SELECT * FROM february_jobs
    UNION
    SELECT * FROM march_jobs
    ) AS first_quarter_jobs
    WHERE NOT job_title_short IS NULL and salary_year_avg > 70000
    ORDER BY salary_year_avg
    limit 100;
