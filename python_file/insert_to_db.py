import psycopg2
import os
from dotenv import load_dotenv

# Define a class to insert dummy data into a database
class InsertDummy:
    def __init__(self):
        # Initialize the connection to the database
        self.conn = self.credential()
        
    def credential(self):
        # Load environment variables from env_config.py
        load_dotenv('database_config/env_config.py')

        # Establish a connection to the database
        conn = psycopg2.connect(
            user=os.environ['DATABASE_USERNAME'],
            password=os.environ['DATABASE_PASSWORD'],
            host=os.environ['DATABASE_HOST'],
            port=os.environ['DATABASE_PORT'],
            database='used_car'
        )
        return conn
        
    def insert_data_from_csv(self, tables):
        try:
            # Create a cursor object
            cur = self.conn.cursor()

            # For each table and corresponding CSV file
            for table_name, csv_file_path in tables.items():
                # Copy the data from the CSV file into the table
                with open(csv_file_path, 'r') as file:
                    cur.copy_expert(f"COPY {table_name} FROM STDIN WITH (FORMAT CSV, HEADER true, DELIMITER ',')", file)

            # Commit the transaction
            self.conn.commit()
            print("Data was successfully inserted")
            
        except (Exception, psycopg2.DatabaseError) as error:
            # Print any errors that occur
            print(f"Error inserting data: {error}")
            
        finally:
            # Close the cursor and the connection
            cur.close()
            self.conn.close()

# Define the path to the data and the tables to insert data into
path = 'dummy_datasets'
tables = {
    'cities': f'{path}/cities_dummy.csv',
    'users': f'{path}/users_dummy.csv',
    'car_brands': f'{path}/brands_dummy.csv',
    'cars': f'{path}/cars_dummy.csv',
    'ads': f'{path}/ads_dummy.csv',
    'bids': f'{path}/bids_dummy.csv',
}

# Create an instance of the class and insert the data
dummy = InsertDummy()
dummy.insert_data_from_csv(tables=tables)