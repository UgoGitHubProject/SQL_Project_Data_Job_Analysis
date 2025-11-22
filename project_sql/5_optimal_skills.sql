/* 
Question: WHAT ARE THE MOST OPTIMAL SKILLS TO LEARN FOR MY ROLE?
Optmial Skill signifies the skill that is in HIGH DEMAND and that is HIGH PAYING. . .

** Identify the skills in high demand and associated with high salaries for DATA ANALYSTS.
** Concentrate on REMOTE positions with specified salaried.
** Why? Target skills that offer job security (HIGH DEMAND) and financial benefits (HIGH SALARIES)
   thus offering strategic insights fir career development in Data Analysis.
*/

WITH skills_demand AS(
        SELECT 
            skills_dim.skill_id AS skill_id,
            skills_dim.skills AS skills,
            COUNT(*) AS demand_count
            
        FROM
            job_postings_fact
        INNER JOIN
            skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN
            skills_dim ON skills_job_dim.skill_id = skillS_dim.skill_id
        WHERE
            job_title_short = 'Data Analyst' AND
            job_work_from_home = True AND
            salary_year_avg IS NOT NULL
        GROUP BY
            skills_dim.skills,
            skills_dim.skill_id

),  average_salary AS(
        SELECT 
            skills_dim.skill_id AS skill_id,
            skills_dim.skills AS skills,
            ROUND(AVG(salary_year_avg), 0) AS avg_salary
            
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
            skills_dim.skills,
            skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    avg_salary DESC,
    demand_count DESC
    
LIMIT 25 ;
