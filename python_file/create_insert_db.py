import psycopg2
import os
from dotenv import load_dotenv

# Define a class to insert dummy data into a database
class CreateInsertQuery:
    def __init__(self):
        # Initialize the connection to the database
        self.conn = self.credential()
        
    def credential(self):
        # Load environment variables from env_config.py
        load_dotenv('database_config/config.py')

        # Establish a connection to the database
        conn = psycopg2.connect(
            user=os.environ['DATABASE_USERNAME'],
            password=os.environ['DATABASE_PASSWORD'],
            host=os.environ['DATABASE_HOST'],
            port=os.environ['DATABASE_PORT'],
            database=os.environ['DATABASE_NAME']
        )
        return conn
    
    def create_tables(self, sql_file):
        try:
            # Create a cursor object
            cur = self.conn.cursor()
            
            # Read the SQL file
            with open(f'{sql_file}', 'r') as file:
                sql_query = file.read()
            
            # Execute the SQL query
            cur.execute(sql_query)
            
            # Commit the transaction
            self.conn.commit()
            print("Successfully created tables!")
            
        except (Exception, psycopg2.DatabaseError) as error:
            # Print any errors that occur
            print("Error: ", error)
        
        finally:
            # Close the cursor
            cur.close()
        
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