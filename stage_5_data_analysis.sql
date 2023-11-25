-- Stage 5: Data Analysis for Netflix Titles Data

-- 1. Most Common First Name Among Actors and Actresses

SELECT TOP 1 SPLIT_PART(actor, ' ', 1) AS first_name, COUNT(*) AS count
FROM (
    SELECT value AS actor
    FROM staging_netflix_titles,
    LATERAL FLATTEN(INPUT => SPLIT(cast, ','))
)
GROUP BY first_name
ORDER BY count DESC;

-- 2. Movie with Longest Timespan from Release to Appearing on Netflix

SELECT TOP 1 title, DATEDIFF(day, TO_DATE(CAST(release_year AS VARCHAR)), date_added) AS days_diff
FROM staging_netflix_titles
WHERE type = 'Movie'
ORDER BY days_diff DESC;

-- 3. Month with Most New Releases Historically

SELECT TOP 1 EXTRACT(month FROM date_added) AS month, COUNT(*) AS release_count
FROM staging_netflix_titles
GROUP BY month
ORDER BY release_count DESC;

-- 4. Year with Largest Increase in TV Shows (Percentage Wise)

WITH yearly_counts AS (
    SELECT EXTRACT(year FROM date_added) AS year, COUNT(*) AS count
    FROM staging_netflix_titles
    WHERE type = 'TV Show'
    GROUP BY year
),
yearly_growth AS (
    SELECT
        a.year,
        a.count AS count,
        ((a.count - LAG(a.count) OVER (ORDER BY a.year)) / LAG(a.count) OVER (ORDER BY a.year)) * 100 AS growth_percentage
    FROM yearly_counts a
)
SELECT TOP 1 year, growth_percentage
FROM yearly_growth
WHERE growth_percentage IS NOT NULL
ORDER BY growth_percentage DESC;

-- 5. List Actresses Appeared More than Once with Woody Harrelson

SELECT actor, COUNT(*) AS appearances
FROM (
    SELECT UNNEST(SPLIT(cast, ',')) AS actor
    FROM staging_netflix_titles
    WHERE cast LIKE '%Woody Harrelson%'
      AND type = 'Movie'
)
WHERE actor <> 'Woody Harrelson'
GROUP BY actor
HAVING COUNT(*) > 1;
