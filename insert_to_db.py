import psycopg2
import os
from dotenv import load_dotenv

class InsertDummy:
    def __init__(self):
        self.conn = self.credential()
        
    def credential(self):
        # Load environment variables from config.py
        load_dotenv('env_config.py')

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
            cur = self.conn.cursor()

            for table_name, csv_file_path in tables.items():
                with open(csv_file_path, 'r') as file:
                    cur.copy_expert(f"COPY {table_name} FROM STDIN WITH (FORMAT CSV, HEADER true, DELIMITER ',')", file)

            self.conn.commit()
            print("Data was successfully inserted")
        except (Exception, psycopg2.DatabaseError) as error:
            print(f"Error inserting data: {error}")
        finally:
            cur.close()
            self.conn.close()

path = 'data_dummy'
tables = {
    'cities': f'{path}/cities_dummy.csv',
    'users': f'{path}/users_dummy.csv',
    'car_brands': f'{path}/brands_dummy.csv',
    'cars': f'{path}/cars_dummy.csv',
    'ads': f'{path}/ads_dummy.csv',
    'bids': f'{path}/bids_dummy.csv',
}

dummy = InsertDummy()
dummy.insert_data_from_csv(tables=tables)