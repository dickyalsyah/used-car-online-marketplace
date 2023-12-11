from faker import Faker
import random
import csv
from datetime import datetime
import pandas as pd

# Initialize faker with Indonesia identity
fake = Faker('id_ID')

# def generate_cities(city_file):
#     df = pd.read_csv(city_file)
#     df['location'] = '(' + df['latitude'].astype(str) + ', ' + df['longitude'].astype(str) + ')'
#     cities = df[['city_id', 'city_name', 'location']]
#     return cities.to_dict('records')

def generate_users(cities, num_records = 100):
    
    city_df = pd.read_csv(cities)
    # Extract city_id to the list from city file    
    city_ids = [val['city_id'] for val in city_df]
    
    # Initialize empty record list
    user_records = []
    
    # Generate data based on number records that we wanted
    for index in range(1, num_records+1):
        user = {
            'user_id': index,
            'name': fake.name(),
            'phone_number': fake.phone_number(),
            'city_id': random.choice(city_ids),
            'zip_code': random.randint(14000, 20000)
        }
        
        # Append every generated data to the record list
        user_records.append(user)
        
    return user_records

def generate_brands():
    # Initiate brand list
    brands = ['Toyota', 'Honda', 'Suzuki', 'Daihatsu', 'BMW', 'Hyundai']
    
    # Generate brand record with the id
    return [{'brand_id': _+1, 'brand_name': val} for _, val in enumerate(brands)]


def generate_cars(brands_data, num_records=50):
    # Define the allowed brands and models
    brands = list(brands_data['brand_name'].unique())
    
    model_allowed = {
        'Toyota' : ['Yaris', 'Agya', 'Alphard', 'Calya', 'Rush', 'Fortuner'],
        'Honda' : ['Jazz', 'CR-V', 'HR-V', 'Brio', 'Mobilio', 'Civic'],
        'Suzuki' : ['Ertiga', 'Baleno', 'Ignis'],
        'Daihatsu' : ['Ayla', 'Xenia', 'Terios'],
        'BMW': ['X Series', '3301'],
        'Hyundai' : ['Santa Fe', 'Creta', 'Ioniq 5']
    }
    
    # Define the allowed body types for each model
    body_type_allowed = {
        'Hatchback': ['Yaris', 'Agya', 'Jazz', 'Brio', 'Ignis', 'Ioniq 5', 'Baleno'],
        'MPV': ['Alphard', 'Rush', 'Mobilio', 'CR-V', 'HR-V', 'Ertiga', 
                'Xenia', 'Terios'],
        'SUV': ['Fortuner', 'Santa Fe', 'Alphard'],
        'Sedan': ['Civic', 'X Series', '3301'],
        'Wagon': ['Calya']
    }

    # Initialize an empty list to store the car records
    car_records = []
    car_ids = set()

    # Generate the specified number of car records
    while len(car_records) < num_records:
        # Randomly select a brand and model
        brand_id = random.randint(1, 6)
        brand = brands[brand_id - 1]
        model = random.choice(model_allowed[brand])

        # Determine the body type based on the model
        body_type = next((condition for condition, models in \
                    body_type_allowed.items() if model in models), 
                        random.choice(['Hatchback', 'MPV', 'SUV', 'Sedan', 'Wagon']))

        # Determine the default fuel type based on the model
        fuel_type = 'Bensin'
        if model == 'Ioniq 5':
            fuel_type = 'Listrik'
        elif model in ['Santa Fe', 'Fortuner']:
            fuel_type = random.choice(['Bensin', 'Diesel'])

        # Randomly select a year of manufacture
        year_manufacture = random.randint(2012, 2022)
        
        # Generate a unique car ID
        car_id = len(car_records)+1
        
        if car_id not in car_ids:
            car_ids.add(car_id)
            # Add the car record to the list
            car_records.append({
                'car_id': car_id, 
                'brand_id': brand_id, 
                'model': f'{brand} {model}', 
                'body_type': body_type, 
                'fuel_type': fuel_type, 
                'year_manufacture': year_manufacture})
    
    return car_records

    
def generate_ads(car_data, brands_data, num_records=200):
    # Initialize an empty list to store the ad records
    ad_records = []
    
    # Create a dictionary of brand names indexed by brand ID
    brand_list = brands_data.set_index('brand_id')['brand_name'].to_dict()
    
    # Generate the specified number of ad records
    for i in range(1, num_records+1):
        # Randomly select a user ID and car ID
        user_id = random.randint(1, 100)
        car_id = random.randint(1, len(car_data))
        
        # Get the car information for the selected car ID
        car_info = car_data.loc[car_data['car_id'] == car_id].iloc[0]
        car_model = car_info['model']
        car_brand = brand_list.get(car_info['brand_id'])
        car_year_manufacture = car_info['year_manufacture']
        
        # Randomly select the data needed
        mileage_km = random.randint(100, 999999)
        color = fake.color_name()
        transmission = random.choice(['AT/Otomatis', 'MT/Manual'])
        price = round(random.randint(1000*20000, 1000*499000)/1000)*1000
        ad_status = random.choice([True, False])
        negotiable = random.choice([True, False])
        
        # Randomly select the post date
        post_date = fake.date_between_dates(date_start=datetime(
            2021, 5, 1), date_end=datetime(2023, 12, 5))
        
        # Generate the ad title and description
        title = f"({car_year_manufacture}) {car_model} - {transmission}"
        description = f"""
            Spesifikasi Mobil
                Merek: {car_brand}
                Model: {car_model}
                Tahun Pembuatan: {car_year_manufacture}
                Transmisi: {transmission}
                Warna: {color}
                Kilometer: {mileage_km}
                {"Harga bisa di NEGO!" if negotiable else ""}
        """
        
        # Add the ad record to the list
        ad_records.append({
            'ad_id': i,
            'user_id': user_id,
            'car_id': car_id,
            'title': title,
            'description': description,
            'mileage_km': mileage_km,
            'color': color,
            'transmission': transmission,
            'price': price,
            'ad_status': ad_status,
            'negotiable': negotiable,
            'post_date': post_date
        })

    return ad_records
        
def generate_bids(ads_data, num_records=300):
    # Select the ads that are negotiable
    negotiable_ad = ads_data[ads_data['negotiable'] == True]
    
    # Initialize an empty list to store the bid records
    bid_records = []
    count = 0
    bid_id = 1  # Initialize bid_id as 1
    
    # Generate the specified number of bid records
    while count < num_records:
        # Randomly select a buyer ID and ad ID
        buyer_id = random.randint(1, 100)
        ad_ids = random.choice(negotiable_ad['ad_id'].to_list())
        
        # Get the ad information for the selected ad ID
        ad_info = ads_data.loc[ads_data['ad_id'] == ad_ids].iloc[0]
        
        # Randomly select the bid price and bid date
        bid_price = round(random.randint(1000*20000, 1000*499000)/500)*500
        bid_date = fake.date_between_dates(date_start=ad_info['post_date'], 
                                            date_end=datetime(2023, 12, 5))
        
        # If the bid price is higher than the ad price or the bid date is 
        # before the post date, skip this iteration
        if bid_price > ad_info['price'] or bid_date <= ad_info['post_date']:
            continue
        
        # Randomly select the bid status
        bid_status = random.choice(['Dikirim', 'Diterima', 'Ditolak'])
        
        # Add the bid record to the list
        bid_records.append({
            'bid_id': bid_id,
            'buyer_id': buyer_id,
            'ad_id': ad_ids,
            'bid_price': bid_price,
            'bid_date': bid_date,
            'bid_status': bid_status
        })
        
        count += 1
        bid_id += 1  # Increment bid_id by 1
    
    return bid_records