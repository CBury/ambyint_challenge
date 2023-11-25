import snowflake.connector
from snowflake.connector import DictCursor

# Snowflake connection parameters
USER = 'your_username'
PASSWORD = 'your_password'
ACCOUNT = 'your_account_identifier'
WAREHOUSE = 'your_warehouse'
DATABASE = 'your_database'
SCHEMA = 'your_schema'

# Establishing connection to Snowflake
conn = snowflake.connector.connect(
    user=USER,
    password=PASSWORD,
    account=ACCOUNT,
    warehouse=WAREHOUSE,
    database=DATABASE,
    schema=SCHEMA
)

# Function to execute a query
def execute_query(query):
    with conn.cursor(DictCursor) as cur:
        cur.execute(query)
        return cur.fetchall()

# Close the connection
conn.close()
