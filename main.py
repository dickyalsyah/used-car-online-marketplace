from python_file.dummy_generator import *
from python_file.create_insert_db import CreateInsertQuery

def main():
    # Definde city_file path
    city_file_path  = './dummy_datasets/cities_raw.csv'
    
    # Generate the dummy data
    cities_data     = generate_cities(city_file=city_file_path)
    users_data      = generate_users(num_records=100, cities=cities_data)
    brands_data     = generate_brands()
    cars_data       = generate_cars(num_records=50, brands_data=brands_data)
    ads_data        = generate_ads(num_records=200, car_data = cars_data, 
                                        brands_data=brands_data)
    bids_data       = generate_bids(num_records=300, ads_data=ads_data)
    
    # Define the path to the data
    folder_name = './dummy_datasets/'
    
    # Save the dummy data to CSV files
    save_to_csv(cities_data, folder_path=folder_name, filename='cities_dummy.csv')
    save_to_csv(users_data, folder_path=folder_name, filename='users_dummy.csv')
    save_to_csv(brands_data, folder_path=folder_name, filename='brands_dummy.csv')
    save_to_csv(cars_data, folder_path=folder_name, filename='cars_dummy.csv')
    save_to_csv(ads_data, folder_path=folder_name, filename='ads_dummy.csv')
    save_to_csv(bids_data, folder_path=folder_name, filename='bids_dummy.csv')

    # Define tables to insert data into
    tables = {
        'cities': f'{folder_name}cities_dummy.csv',
        'users': f'{folder_name}users_dummy.csv',
        'car_brands': f'{folder_name}brands_dummy.csv',
        'cars': f'{folder_name}cars_dummy.csv',
        'ads': f'{folder_name}ads_dummy.csv',
        'bids': f'{folder_name}bids_dummy.csv',
    }

    # Create an instance of the class and insert the data
    dummy = CreateInsertQuery()
    dummy.create_tables(sql_file='query/table_creation.sql')
    dummy.insert_data_from_csv(tables=tables)

if __name__ == "__main__":
    main()