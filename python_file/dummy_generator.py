from faker import Faker
import random
import csv
from datetime import datetime
import os

# Initialize faker with Indonesia identity
fake = Faker('id_ID')

def generate_cities(city_file):
    # Open the CSV file
    with open(city_file, 'r') as f:
        # Use csv.DictReader to read the CSV file into a list of dictionaries
        reader = csv.DictReader(f)
        
        # Initialize an empty list to store the cities
        cities_records = []
        
        # Iterate over each row in the CSV file
        for row in reader:
            # Append the city dictionary to the cities list
            cities_records.append({
            'city_id' : row['city_id'],
            'city_name' : row['city_name'],
            'location' : row['latitude'] + ', ' + row['longitude']
            })
            
        return cities_records

def generate_users(cities, num_records = 100):
    
    # Extract city_id to the list from city file    
    city_ids = [val['city_id'] for val in cities]
    city_ids = [city['city_id'] for city in cities]
    
    # Initialize empty record list and set unique names
    user_records = []
    unique_names = set()
    
    # Generate data based on number records that we wanted
    while len(user_records) < num_records:
        first_name = fake.first_name()
        last_name = fake.last_name()
        
        full_name = (f'{first_name} {last_name}')
        
        if full_name not in unique_names:
            unique_names.add(full_name)
            
            # Append every generated data to the record list
            user_records.append({
                'user_id': len(user_records) + 1,
                'name': full_name,
                'phone_number': fake.phone_number(),
                'city_id': random.choice(city_ids),
                'zip_code': random.randint(14000, 20000)
            })
            
    return user_records

def generate_brands():
    # Initiate brand list
    brands = ['Toyota', 'Honda', 'Suzuki', 'Daihatsu', 'BMW', 'Hyundai']
    
    # Generate brand record with the id
    return [{'brand_id': _+1, 'brand_name': val} for _, val in enumerate(brands)]


def generate_cars(brands_data, num_records=50):
    # Define the allowed brands and models
    brands = list(set([brand['brand_name'] for brand in brands_data]))
    
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
        brand_id = random.randint(1, len(brands))
        brand = next((brand['brand_name'] for brand in brands_data if brand['brand_id'] == brand_id), None)
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
        car_id = len(car_records) + 1
        
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
    
    # Generate the specified number of ad records
    for i in range(1, num_records + 1):
        # Randomly select a user ID and car ID
        user_id = random.randint(1, 100)
        
        # Create a dictionary mapping car_id to car data
        car_dict = {car['car_id']: car for car in car_data}
        car_id = random.randint(1, len(car_data))
        
        # Get the car information for the selected car ID
        car = car_dict.get(car_id)
        if car:
            car_model = car['model']
            car_brand = next((brand['brand_name'] for brand in brands_data if brand['brand_id'] == car['brand_id']), None)
            car_year_manufacture = car['year_manufacture']
        
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
    negotiable_ad = [ad['ad_id'] for ad in ads_data if ad['negotiable']]
    
    # Initialize an empty list to store the bid records
    bid_records = []
    count = 0
    bid_id = 1  # Initialize bid_id as 1
    
    # Generate the specified number of bid records
    while count < num_records:
        # Randomly select a buyer ID and ad ID
        buyer_id = random.randint(1, 100)
        ad_ids = random.choice(negotiable_ad)
        
        # Get the ad information for the selected ad ID
        ad_info = {ad['ad_id']: ad for ad in ads_data}
        
        # Get the car information for the selected car ID
        ad = ad_info.get(ad_ids)
        
        # Randomly select the bid price and bid date
        bid_price = round(random.randint(1000*20000, 1000*499000)/500)*500
        bid_date = fake.date_between_dates(date_start=ad['post_date'], 
                                            date_end=datetime(2023, 12, 5))
        
        # If the bid price is higher than the ad price or the bid date is 
        # before the post date, skip this iteration
        if bid_price > ad['price'] or bid_date <= ad['post_date']:
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

def save_to_csv(data, folder_path, filename):
    
    # Create the folder if it doesn't exist
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)

    # Construct the full file path with the folder and filename
    file_path = os.path.join(folder_path, filename)

    # Extract the keys from the first dictionary in the data list
    fieldnames = list(data[0].keys())

    # Open the CSV file in write mode
    with open(file_path, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        # Write the header row
        writer.writeheader()
        
        # Write the data rows
        for row in data:
            writer.writerow(row)

    print("Data has been written to", filename)