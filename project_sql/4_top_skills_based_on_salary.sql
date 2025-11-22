/* 
Question: WHAT ARE THE TOP SKILLS BASED ON SALARY FOR MY ROLE?
In other words, WHAT ARE THE MOST IN-DEMAND SKILLS FOR DATA ANALYSTS BASED ON SALARY?

** Look at the average salary associated with each skill for Data Analysts positions.
** Focuses on roles with specified salaries, regardless of location.
** Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most 
   financially rewarding skills to acquire or improve on.

** THE GOAL IS TO DETERMINE THE AVERAGE SALARY OF THE SKILLS. 
   In other words, TOP SKILLS BASED ON AVERAGE SALARY. . . . 
*/


SELECT 
    skills_dim.skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
    
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skillS_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    average_salary DESC
LIMIT 25 ;