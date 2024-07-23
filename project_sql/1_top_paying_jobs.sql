/* 
Question: WHat are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Hightlight the top-paying opportunities for Data Analysts, offering insights into employee 
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
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10

/*
High Salary Range: Top-paying job is Data Analyst at Mantys ($650,000), with senior roles at Meta ($336,500) and AT&T ($255,829.5) also highly compensated.
Valued Roles: Leadership and specialized roles like Director of Analytics, Associate Director- Data Insights, and Principal Data Analyst are in high demand.
Flexible Work: All positions are full-time with many offering remote or hybrid options, emphasizing the trend towards flexible work arrangements.

*/