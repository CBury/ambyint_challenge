-- Creating Dimension Tables

-- Dim_Type table
CREATE TABLE Dim_Type (
    type_id INT AUTOINCREMENT PRIMARY KEY,
    type VARCHAR(100)
);

-- Dim_Title table
CREATE TABLE Dim_Title (
    title_id INT AUTOINCREMENT PRIMARY KEY,
    title VARCHAR(255)
);

-- Dim_Director table
CREATE TABLE Dim_Director (
    director_id INT AUTOINCREMENT PRIMARY KEY,
    director_name VARCHAR(255)
);

-- Dim_Country table
CREATE TABLE Dim_Country (
    country_id INT AUTOINCREMENT PRIMARY KEY,
    country_name VARCHAR(255)
);

-- Dim_Date_Added table
CREATE TABLE Dim_Date_Added (
    date_added_id INT AUTOINCREMENT PRIMARY KEY,
    date_added DATE
);

-- Dim_Release_Year table
CREATE TABLE Dim_Release_Year (
    release_year_id INT AUTOINCREMENT PRIMARY KEY,
    release_year INT
);

-- Dim_Rating table
CREATE TABLE Dim_Rating (
    rating_id INT AUTOINCREMENT PRIMARY KEY,
    rating VARCHAR(50)
);

-- Dim_Duration table
CREATE TABLE Dim_Duration (
    duration_id INT AUTOINCREMENT PRIMARY KEY,
    duration VARCHAR(100)
);

-- Dim_Genre table
CREATE TABLE Dim_Genre (
    genre_id INT AUTOINCREMENT PRIMARY KEY,
    genre VARCHAR(255)
);

-- Dim_Cast table
CREATE TABLE Dim_Cast (
    cast_id INT AUTOINCREMENT PRIMARY KEY,
    cast_name VARCHAR(255)
);

-- Creating Fact Table

-- Fact_Movie_Show table
CREATE TABLE Fact_Movie_Show (
    show_id VARCHAR(100) PRIMARY KEY,
    type_id INT,
    title_id INT,
    director_id INT,
    country_id INT,
    date_added_id INT,
    release_year_id INT,
    rating_id INT,
    duration_id INT,
    genre_id INT,
    FOREIGN KEY (type_id) REFERENCES Dim_Type(type_id),
    FOREIGN KEY (title_id) REFERENCES Dim_Title(title_id),
    FOREIGN KEY (director_id) REFERENCES Dim_Director(director_id),
    FOREIGN KEY (country_id) REFERENCES Dim_Country(country_id),
    FOREIGN KEY (date_added_id) REFERENCES Dim_Date_Added(date_added_id),
    FOREIGN KEY (release_year_id) REFERENCES Dim_Release_Year(release_year_id),
    FOREIGN KEY (rating_id) REFERENCES Dim_Rating(rating_id),
    FOREIGN KEY (duration_id) REFERENCES Dim_Duration(duration_id),
    FOREIGN KEY (genre_id) REFERENCES Dim_Genre(genre_id)
);

-- Bridge Table for Many-to-Many Relationship

-- Fact_Movie_Show_Cast table
CREATE TABLE Fact_Movie_Show_Cast (
    show_id VARCHAR(100),
    cast_id INT,
    FOREIGN KEY (show_id) REFERENCES Fact_Movie_Show(show_id),
    FOREIGN KEY (cast_id) REFERENCES Dim_Cast(cast_id)
);
