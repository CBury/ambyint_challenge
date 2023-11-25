-- Stage 2: ELT Process for Netflix Titles Data

-- Step 1: Creating a Stage for Loading CSV Data
CREATE STAGE netflix_stage;

-- Step 2: Loading Data into Staging Table

COPY INTO staging_netflix_titles
FROM @netflix_stage/netflix_titles.csv
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);

-- Step 3: Transforming and Loading Data into Dimensional Model

-- Transform and Load into Dim_Type
INSERT INTO Dim_Type (type)
SELECT DISTINCT type
FROM staging_netflix_titles;

-- Transform and Load into Dim_Title
INSERT INTO Dim_Title (title)
SELECT DISTINCT title
FROM staging_netflix_titles;

-- Transform and Load into Dim_Director
INSERT INTO Dim_Director (director_name)
SELECT DISTINCT director
FROM staging_netflix_titles
WHERE director IS NOT NULL AND director <> '';

-- Transform and Load into Dim_Country
INSERT INTO Dim_Country (country_name)
SELECT DISTINCT country
FROM staging_netflix_titles
WHERE country IS NOT NULL AND country <> '';

-- Transform and Load into Dim_Date_Added
INSERT INTO Dim_Date_Added (date_added)
SELECT DISTINCT date_added
FROM staging_netflix_titles
WHERE date_added IS NOT NULL;

-- Transform and Load into Dim_Release_Year
INSERT INTO Dim_Release_Year (release_year)
SELECT DISTINCT release_year
FROM staging_netflix_titles
WHERE release_year IS NOT NULL;

-- Transform and Load into Dim_Rating
INSERT INTO Dim_Rating (rating)
SELECT DISTINCT rating
FROM staging_netflix_titles
WHERE rating IS NOT NULL AND rating <> '';

-- Transform and Load into Dim_Duration
INSERT INTO Dim_Duration (duration)
SELECT DISTINCT duration
FROM staging_netflix_titles
WHERE duration IS NOT NULL AND duration <> '';

-- Transform and Load into Dim_Genre
INSERT INTO Dim_Genre (genre)
SELECT DISTINCT listed_in AS genre
FROM staging_netflix_titles
WHERE listed_in IS NOT NULL AND listed_in <> '';

INSERT INTO Dim_Cast (cast_name)
SELECT DISTINCT TRIM(value)
FROM staging_netflix_titles,
LATERAL FLATTEN(INPUT => SPLIT(cast, ','));

-- Step 4: Loading Data into Fact_Movie_Show
INSERT INTO Fact_Movie_Show (
    show_id,
    type_id,
    title_id,
    director_id,
    country_id,
    date_added_id,
    release_year_id,
    rating_id,
    duration_id,
    genre_id
)
SELECT
    s.show_id,
    t.type_id,
    tl.title_id,
    d.director_id,
    c.country_id,
    da.date_added_id,
    ry.release_year_id,
    r.rating_id,
    du.duration_id,
    g.genre_id
FROM staging_netflix_titles s
LEFT JOIN Dim_Type t ON s.type = t.type
LEFT JOIN Dim_Title tl ON s.title = tl.title
LEFT JOIN Dim_Director d ON s.director = d.director_name
LEFT JOIN Dim_Country c ON s.country = c.country_name
LEFT JOIN Dim_Date_Added da ON s.date_added = da.date_added
LEFT JOIN Dim_Release_Year ry ON s.release_year = ry.release_year
LEFT JOIN Dim_Rating r ON s.rating = r.rating
LEFT JOIN Dim_Duration du ON s.duration = du.duration
LEFT JOIN Dim_Genre g ON s.listed_in = g.genre;
