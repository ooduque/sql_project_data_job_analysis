
SELECT
    skill_id,
    skills AS skill_name
FROM
    skills_dim
WHERE skill_id IN (
    SELECT 
        skills_job_dim.skill_id
    FROM
        skills_job_dim
    GROUP BY
        skills_job_dim.skill_id
    ORDER BY 
        COUNT(*) DESC
    LIMIT 5
);


SELECT
    COUNT(company_id) AS company_size
    CASE 
        WHEN company_id = 10 THEN 'small'
        WHEN company_id BETWEEN 10 AND 50 THEN 'medium'
        ELSE 'large'
    END
FROM 
    job_postings_fact
WHERE company_id IN(
SELECT
    company_id,
    COUNT(*)
FROM
    job_postings_fact   
GROUP BY
    company_id
ORDER BY 
    COUNT(*) DESC
);

SELECT
    COUNT(company_id) AS company_size,
    CASE 
        WHEN COUNT(company_id) <= 10 THEN 'small'
        WHEN COUNT(company_id) BETWEEN 11 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_category
FROM 
    job_postings_fact
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact   
    GROUP BY
        company_id
    ORDER BY 
        COUNT(*) DESC
)
GROUP BY company_id, company_category;

SELECT
    company_id,
    company_size,
    CASE 
        WHEN company_size <= 10 THEN 'small'
        WHEN company_size BETWEEN 11 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_category
FROM (
    SELECT
        company_id,
        COUNT(company_id) AS company_size
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
    ORDER BY 
        COUNT(company_id) DESC
) AS subquery
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact   
    GROUP BY
        company_id
    ORDER BY 
        COUNT(*) DESC
);
--Another implementation

SELECT
    company_id,
    no_of_jobs,
    CASE 
        WHEN no_of_jobs <= 10 THEN 'small'
        WHEN no_of_jobs BETWEEN 11 AND 50 THEN 'medium'
        ELSE 'large'
    END AS company_category
FROM (
    SELECT
        company_id,
        COUNT(*) AS no_of_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
    ORDER BY 
        COUNT(*) DESC
    LIMIT 5
) AS subquery;

SELECT 
    job_title_short,
    company_id,
    job_location    
FROM 
    january_jobs    

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM    
    march_jobs;


