/* 
Question: WHAT ARE THE TOP-PAYING DATA ANALYST JOBS?

THE FOLLOWING STRATEGIES WILL BE APPLIED:
    ** Identify the top 10 highest-paying DATA ANALYST roles that are avialable REMOTELY.
    ** Focus on job postings with specified salaries (remove null values for salaries).
    ** Why? Highlight the top-paying oppurtunities for Data Analysts, offering insights into 
    ** employments in different companies. . . . 
*/

SELECT
    job_id, 
    job_title, 
    job_location,
    job_schedule_type, 
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim
ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL 
ORDER BY
    salary_year_avg DESC
LIMIT 15 ;