/* 
Question: WHAT ARE THE MOST IN-DEMAND SKILLS FOR DATA ANALYSTS?

** Join job postings table to inner join table similar to query 2.
** Identify the top 5 in-demand skills for a DATA ANALYST
** Focus on ALL job postings
** Why? Retrieves the top 5 skills with the HIGHEST DEMAND in the job market, 
** providing insights into the MOST VALUABLE SKILLS for job seekers. . . . 

** THE GOAL IS TO DETERMINE THE COUNT OF THE SKILLS. In other words, TOP SKILLS BASED ON COUNT. . . . 
*/


SELECT 
    skills_dim.skills,
    COUNT(*) AS demand_count
    
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skillS_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5 ;




-- Alternative Query Using A SubQuery

SELECT
    skills,
    skill_count

FROM(
    SELECT
        skill_id,
        COUNT(job_postings_fact.job_id) AS skill_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
    ON
        job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.job_work_from_home = True
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5 
) AS skill_demand

INNER JOIN
    skills_dim
ON
    skill_demand.skill_id = skills_dim.skill_id
ORDER BY
        skill_count DESC ;