# Introduction
A look into the data job market by analyzing the postings of data job openings. Focusing on roles for Data Analyst, this project explores in-demand skills, top-paying jobs, and where high demand meets high salary in Data Analytics.

To see the SQL queries, check here: 
[project_sql folder](/project_sql/)



# Background
To understand the data job market better, it became imperative to analyze the data job postings for several positions from several locations (cities and countries). This analysis was predicated on the desire for top-paying jobs, knowledge of the skills that are in high demand, and the most optimal skills for a Data Analyst position. Such insights will guide the decisions of job seekers or even professionals in the Data-Inclined field.

Five questions will be answered in this project. They include;
1.	What are the top-paying Data Analyst jobs?
2.	What skills are needed for the top-paying Data Analyst jobs?
3.	What are the most in-demand skills for a Data Analyst?
4.	What are the top skills based on salary for a Data Analyst?
5.	What are the most optimal skills (high-demand, high-paying) for a Data Analyst role?

# Tools I Used
To achieve the set objective of analyzing data job postings to answer some preset questions, the capabilities of several tools and languages were utilized. These included:

**SQL:** This was used to communicate with a relational database that contains job postings, the names of companies that posted the jobs, and the skills mentioned in each posting. This communication was achieved through queries designed to retrieve datasets from a database in line with the questions to be answered. 

**PostgreSQL:** The particular Relational Database Management System used in this project. Used to execute Joins, Subqueries, and Common Table Expressions that are applied to derive the data needed to answer the questions.

**Git and GitHub:** The Version Control System (Git) and the hosting platform (GitHub) were used to prepare the files for display and sharing with the public, track changes made to the files, and publish the necessary files to the public.

**VS Code:** This was the Code Editor used to write the SQL queries, in the Postgres syntax, to communicate with the database. It was also used to upload files (and changes to files) to GitHub.

# The Analysis
This section presents the investigation of the job market data through an analysis of the data job postings. 

The snippet of the queries written and executed, with the results obtained, is included for each question answered. 

A brief description of the methodology applied in answering each question is also presented.

### Q1: What are the top-paying Data Analyst jobs?
Determining the jobs in the Data Analyst role that have the highest yearly salary. 

Answering this question required filtering the data for Data Analyst roles, which involved only REMOTE WORK. Information on the job title, company name, and schedule type (e.g, full-time, part-time, etc.) was also provided.

Results from this analysis presents the various employment opportunities for a Data Analyst, and the roles a Data Analyst can play in a company. This can help in targeting specific companies for oppurtunities.

SQL code is shown below

```sql
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
```
#### INSIGHTS
The role of a Data Analyst takes several job titles, which vary from one company to another.

Salaries Range Widely from $165,000 to $650,000.

Most Salaries Cluster Between $165k and $230k. This defines the optimal salary range for Intermediate to Senior Data Analyst roles.

Senior Roles Pay Significantly More. Director and Principal titles (e.g., "Director of Analytics", "Principal Data Analyst") pay $180k–$336k. Demonstrates a clear progression in salary with seniority.

Different companies pay different salaries for the role. This may be based on cader and experience.

![Salaries from different companies](images\Top_Ten_Companies_With_Most_Pay_For_Data_Analysts.jpg) *Plot of Average Yearly Salary for Work From Home Location Data Analyst Role from Different Companies*

![Salaries for different Data Analyst Roles](images\Top_Ten_Highest_Paying_Data_Analyst_Roles.jpg)*Plot of Average Yearly Salary for Work From Home Location for different Data Analyst Roles*


### Q2: What are the skills for the top-paying Data Analyst jobs?

Presents the skills that are required for those jobs that pay the most in a Data Analyst role.

To answer this question, the dataset was filtered based on yearly salary values that were NOT NULL, while returning the information for the job identification, title, company name, and salary sorted in descending order. The jobs were then sorted in decreasing order of average salary values.  

A JOIN operation was used to extract the skills and company names (from their respective dimension tables) that matched the high-paying jobs.

The result of this analysis will provide invaluable information on the skills required to aspire for any top-paying Data Analyst role in a particular organization. Any data professional seeking a high-paying role in any company will be aware of the skills needed for such a position.

SQL code is shown below
```sql
WITH top_paying_jobs AS(

        SELECT
            job_id, 
            job_title, 
            salary_year_avg,
            name AS company_name
        FROM
            job_postings_fact
        LEFT JOIN
            company_dim
        ON
            job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL 
        ORDER BY
            salary_year_avg DESC
        LIMIT 50000 
)
SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC ;
```

An alternative SQL code for this is shown below,
```SQL
SELECT
        jpf.job_id,
        jpf.job_title,
        jpf.salary_year_avg AS average_yearly_salary,
        cd.name AS company_name,
        skd.skills AS job_skills
FROM
    job_postings_fact AS jpf
INNER JOIN
    company_dim AS cd  ON jpf.company_id = cd.company_id
INNER JOIN
    skills_job_dim AS skjd ON skjd.job_id = jpf.job_id
INNER JOIN
    skills_dim AS skd ON skjd.skill_id = skd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL 
ORDER BY
    jpf.salary_year_avg DESC
LIMIT
    50000 ;
```
#### INSIGHTS
Most in-demand skills for the High-Paying Data Analyst role are not NECESSARILY the same as the Highest-Paying skills.

For the top-paying Data Analyst jobs, SQL is the Most In-Demand skill, followed by Python, Tableau, R, SaS, Excel, and Power BI. Thus, to land a top-paying Data Analyst role, SQL is a MUST-HAVE skill.

Specialized skills in Web Applications, Cloud applications, and DevOps will significantly contribute to achieving a much higher pay in a Data Analyst role. Skills in these areas make up most of the Highest-Paying skills set.

For the most in-demand skills of the top paying job skills, VISUALIZATION and ANALYTICAL skills contributed more to a high-paying Data Analyst role. The Database Manipulation skill has a lower influence (in comparison) on the pay of the Data Analyst role.

![Top ten In-Demand Skills for High Paying Data Analyst Jobs](images\Top_10_Most_InDemand_Skills_for_High_Paying_Data_Analyst_Jobs.jpg)*Plot of Most In-Demand Skills for High Paying Data Analyst Jobs*

![Skills for Top Paying Data Analyst Jobs](images\Analysis_of_Skills_for_Top_Paying_Data_Analyst_Jobs.jpg) *Plot of Top Paying Skills and Top Paying Most In-Demand Skills for High Paying Data Analyst Jobs


-	What I Learned
-	Conclusions
-	Looking Forward

