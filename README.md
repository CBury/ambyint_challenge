# Netflix Titles Data Engineering Project

This project involves creating a comprehensive data pipeline using Snowflake and Python, centered around the netflix_titles.csv dataset. The pipeline includes database schema design, data loading and transformation (ELT), data validation, and analytical querying.
## Table of Contents

- [Stage 1: Database Setup](#stage-1-database-setup)
- [Stage 2: Data Loading (ELT)](#stage-2-data-loading-elt)
- [Stage 3: Data Generation with Python](#stage-3-data-generation-with-python)
- [Stage 4: Data Validation](#stage-4-data-validation)
- [Stage 5: Data Analysis](#stage-5-data-analysis)
- [Installation](#installation)
- [Usage](#usage)


## Stage 1: Database Setup

Designed and implemented a dimensional data model in Snowflake for the `netflix_titles.csv` dataset. This stage involves creating a series of dimension and fact tables to accurately represent the data.

## Stage 2: Data Loading (ELT)

Developed an ELT process to load and transform data from `netflix_titles.csv` into the Snowflake schema, involving staging the CSV data, followed by loading it into the dimensional model.

## Stage 3: Data Generation with Python

Included is a Python script (`generate_data.py`) for generating new CSV files with fictitious records, mirroring the format of `netflix_titles.csv`.

## Stage 4: Data Validation

SQL queries and views have been created in Snowflake to validate the data. These include checks for missing data, invalid formats, and data anomalies.

## Stage 5: Data Analysis

Several analytical SQL queries are implemented to extract insights from the dataset, answering specific questions related to the Netflix titles.


## Installation

Before you begin, ensure you have Python installed on your system. This project requires Python 3.6 or later. Additionally, you'll need access to a Snowflake account to create and manage your database and data warehouse.

### Setting Up Python Environment

1. **Clone the Repository**: First, clone this repository to your local machine using:

   ```bash
   git clone https://github.com/CBury/ambyint_challenge
   cd ambyint_challenge
   
2. **Create a Virtual Environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
3. **Install Required Packages**
   ```bash
   pip install -r requirements.txt
   
4. **Setting Up Snowflake**

***Create Snowflake Account:*** Sign up for a Snowflake account at Snowflake's website.

***Set Up Database Objects:*** Use the provided SQL DDL scripts in the sql_scripts folder to set up your database schema in Snowflake.

***Configure Connection:*** Configure your Snowflake connection parameters in the Python scripts or as environment variables, including your account name, username, password, and other necessary information.


## Usage

After installation, you're ready to run the scripts and perform operations on your Snowflake database.

### Running the Python Scripts

1. **Data Generation**: To generate new data files:

   ```bash
   python generate_data.py

2. **Data Loading and Analysis**

***Load Data:*** Use the stage_2_elt_process.sql script to load data into Snowflake.

***Validate Data:*** Run the stage_4_data_validation.sql for data validation.

***Analyze Data:*** Execute queries in stage_5_data_analysis.sql for data analysis.
