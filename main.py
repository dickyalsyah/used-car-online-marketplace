from python_file.dummy_generator import *
from python_file.insert_to_db import InsertDummy
import pandas as pd

def main():
    # Definde city_file path
    city_file_path = 'dummy_datasets/cities_dummy.csv'
    
    # Generate the dummy data
    users_data = pd.DataFrame(generate_users(100, cities=city_file_path))
    brands_data = pd.DataFrame(generate_brands())
    cars_data = pd.DataFrame(generate_cars(50, brands_data=brands_data))
    ads_data = pd.DataFrame(generate_ads(200, car_data = cars_data, 
                                        brands_data=brands_data))
    bids_data = pd.DataFrame(generate_bids(300, ads_data=ads_data))
    
    # Define the path to the data
    path = 'dummy_datasets'
    
    # Save the dummy data to CSV files
    users_data.to_csv(f'{path}/users_dummy.csv', index=False)
    brands_data.to_csv(f'{path}/brands_dummy.csv', index=False)
    cars_data.to_csv(f'{path}/cars_dummy.csv', index=False)
    ads_data.to_csv(f'{path}/ads_dummy.csv', index=False)
    bids_data.to_csv(f'{path}/bids_dummy.csv', index=False)

    # Define tables to insert data into
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

if __name__ == "__main__":
    main()