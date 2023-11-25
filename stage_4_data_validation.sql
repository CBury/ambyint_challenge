-- Stage 4: Data Validation for Netflix Titles Data

-- 1. Check for Missing Data in Key Columns

-- Check for missing data in staging table
SELECT 'staging_netflix_titles' AS table_name, COUNT(*) AS missing_count
FROM staging_netflix_titles
WHERE show_id IS NULL OR type IS NULL OR title IS NULL OR director IS NULL
UNION ALL

-- Check for missing data in Dim_Type
SELECT 'Dim_Type' AS table_name, COUNT(*) AS missing_count
FROM Dim_Type
WHERE type_id IS NULL OR type IS NULL
UNION ALL

-- Check for missing data in Dim_Title
SELECT 'Dim_Title' AS table_name, COUNT(*) AS missing_count
FROM Dim_Title
WHERE title_id IS NULL OR title IS NULL
UNION ALL

-- Check for missing data in Dim_Director
SELECT 'Dim_Director' AS table_name, COUNT(*) AS missing_count
FROM Dim_Director
WHERE director_id IS NULL OR director_name IS NULL
UNION ALL

-- Check for missing data in Dim_Country
SELECT 'Dim_Country' AS table_name, COUNT(*) AS missing_count
FROM Dim_Country
WHERE country_id IS NULL OR country_name IS NULL
UNION ALL

-- Check for missing data in Dim_Date_Added
SELECT 'Dim_Date_Added' AS table_name, COUNT(*) AS missing_count
FROM Dim_Date_Added
WHERE date_added_id IS NULL OR date_added IS NULL
UNION ALL

-- Check for missing data in Dim_Release_Year
SELECT 'Dim_Release_Year' AS table_name, COUNT(*) AS missing_count
FROM Dim_Release_Year
WHERE release_year_id IS NULL OR release_year IS NULL
UNION ALL

-- Check for missing data in Dim_Rating
SELECT 'Dim_Rating' AS table_name, COUNT(*) AS missing_count
FROM Dim_Rating
WHERE rating_id IS NULL OR rating IS NULL
UNION ALL

-- Check for missing data in Dim_Duration
SELECT 'Dim_Duration' AS table_name, COUNT(*) AS missing_count
FROM Dim_Duration
WHERE duration_id IS NULL OR duration IS NULL
UNION ALL

-- Check for missing data in Dim_Genre
SELECT 'Dim_Genre' AS table_name, COUNT(*) AS missing_count
FROM Dim_Genre
WHERE genre_id IS NULL OR genre IS NULL
UNION ALL

-- Check for missing data in Fact_Movie_Show
SELECT 'Fact_Movie_Show' AS table_name, COUNT(*) AS missing_count
FROM Fact_Movie_Show
WHERE show_id IS NULL OR type_id IS NULL OR title_id IS NULL OR director_id IS NULL

-- 2. Validate Data Types or Formats

-- Validate release_year format (four digits)
SELECT 'staging_netflix_titles' AS table_name, show_id, release_year
FROM staging_netflix_titles
WHERE NOT REGEXP_LIKE(release_year, '^[0-9]{4}$');

-- 3. Identify Strange or Anomalous Data

-- Identify unusually short duration for movies or shows
SELECT show_id, duration
FROM staging_netflix_titles
WHERE type = 'Movie' AND SPLIT_PART(duration, ' ', 1)::INT < 60
   OR type = 'TV Show' AND SPLIT_PART(duration, ' ', 1)::INT < 1;

-- 4. Check for Duplicate Data

-- Check for duplicate show IDs
SELECT show_id, COUNT(*)
FROM staging_netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;
