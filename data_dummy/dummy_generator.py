from faker import Faker
import random
from datetime import datetime
import pandas as pd

fake = Faker('id_ID')

def generate_users(num_records = 100):
    city_ids = [
        3171, 3172, 3173, 
        3174, 3175, 3573, 
        3578, 3471, 3273, 
        1371, 1375, 6471, 
        6472, 7371, 5171
    ]
    
    user_records = []
    
    for index in range(1, num_records+1):
        user = {
            'user_id': index,
            'name': fake.name(),
            'phone_number': fake.phone_number(),
            'city_id': random.choice(city_ids),
            'zip_code': random.randint(14000, 20000)
        }
        
        user_records.append(user)
        
    return user_records

users_data = pd.DataFrame(generate_users())

def generate_brands():
    # Initiate brand list
    brands = ['Toyota', 'Honda', 'Suzuki', 'Daihatsu', 'BMW', 'Hyundai']
    
    return [{'brand_id': _+1, 'brand_name': val} for _, val in enumerate(brands)]

brands_data = pd.DataFrame(generate_brands())

def generate_cars(num_records = 50):
    brands = [val for i in generate_brands() for _, val in i.items() if _ == 'brand_name']
    
    model_allowed = {
        'Toyota' : ['Yaris', 'Agya', 'Alphard', 'Calya', 'Rush', 'Fortuner'],
        'Honda' : ['Jazz', 'CR-V', 'HR-V', 'Brio', 'Mobilio', 'Civic'],
        'Suzuki' : ['Ertiga', 'Baleno', 'Ignis'],
        'Daihatsu' : ['Ayla', 'Xenia', 'Terios'],
        'BMW': ['X Series', '3301'],
        'Hyundai' : ['Santa Fe', 'Creta', 'Ioniq 5']
    }
    
    body_type_allowed = {
        'Hatchback': ['Yaris', 'Agya', 'Jazz', 'Brio', 'Ignis', 'Ioniq 5', 'Baleno'],
        'MPV': ['Alphard', 'Rush', 'Mobilio', 'CR-V', 'HR-V', 'Ertiga', 'Xenia', 'Terios'],
        'SUV': ['Fortuner', 'Santa Fe', 'Alphard'],
        'Sedan': ['Civic', 'X Series', '3301'],
        'Wagon': ['Calya']
    }

    car_records = []
    car_ids = set()

    while len(car_records) < num_records:
        brand_id = random.randint(1, 6)
        brand = brands[brand_id - 1]
        model = random.choice(model_allowed[brand])

        body_type = next((condition for condition, models in body_type_allowed.items() if model in models), 
                        random.choice(['Hatchback', 'MPV', 'SUV', 'Sedan', 'Wagon']))

        fuel_type = 'Bensin'
        if model == 'Ioniq 5':
            fuel_type = 'Listrik'
        elif model in ['Santa Fe', 'Fortuner']:
            fuel_type = random.choice(['Bensin', 'Diesel'])

        year_manufacture = random.randint(2012, 2022)
        
        car_id = len(car_records)+1
        if car_id not in car_ids:
            car_ids.add(car_id)
            car_records.append({
                'car_id': car_id, 
                'brand_id': brand_id, 
                'model': f'{brand} {model}', 
                'body_type': body_type, 
                'fuel_type': fuel_type, 
                'year_manufacture': year_manufacture})
    
    return car_records
    
cars_data = pd.DataFrame(generate_cars())
    
def generate_ads(num_records = 200, car_data = cars_data):
    ad_records = []
    brand_list = brands_data.set_index('brand_id')['brand_name'].to_dict()
    for i in range(1, num_records+1):
        user_id = random.randint(1, 100)
        car_id = random.randint(1, len(car_data))
        car_info = car_data.loc[car_data['car_id'] == car_id].iloc[0]
        car_model = car_info['model']
        car_brand = brand_list.get(car_info['brand_id'])
        car_year_manufacture = car_info['year_manufacture']
        mileage_km = random.randint(100, 999999)
        color = fake.color_name()
        transmission = random.choice(['AT/Otomatis', 'MT/Manual'])
        price = round(random.randint(1000*20000, 1000*499000)/1000)*1000
        ad_status = random.choice([True, False])
        negotiable = random.choice([True, False])
        post_date = fake.date_between_dates(date_start=datetime(
            2021, 5, 1), date_end=datetime(2023, 12, 5))
        
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
        
        ad_records.append({
            "ad_id": i,
            "user_id": user_id,
            "car_id": car_id,
            "title": title,
            "description": description,
            "mileage_km": mileage_km,
            "color": color,
            "transmission": transmission,
            "price": price,
            "ad_status": ad_status,
            "negotiable": negotiable,
            "post_date": post_date
        })

    return ad_records

ads_data = pd.DataFrame(generate_ads())
        
def generate_bids(num_records=300, ads_data=ads_data):
    negotiable_ad = ads_data[ads_data['negotiable'] == True]
    
    bid_records = []
    count = 0
    bid_id = 1  # Initialize bid_id as 1
    
    while count < num_records:
        buyer_id = random.randint(1, 100)
        ad_ids = random.choice(negotiable_ad['ad_id'].to_list())
        ad_info = ads_data.loc[ads_data['ad_id'] == ad_ids].iloc[0]
        bid_price = round(random.randint(1000*20000, 1000*499000)/500)*500
        bid_date = fake.date_between_dates(date_start=ad_info['post_date'], date_end=datetime(2023, 12, 5))
        
        if bid_price > ad_info['price'] or bid_date <= ad_info['post_date']:
            continue
        
        bid_status = random.choice(['Dikirim', 'Diterima', 'Ditolak'])
        
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

bids_data = pd.DataFrame(generate_bids(300, ads_data))

# Save to csv
users_data.to_csv('users_dummy.csv', index=False)
brands_data.to_csv('brands_dummy.csv', index=False)
cars_data.to_csv('cars_dummy.csv', index=False)
ads_data.to_csv('ads_dummy.csv', index=False)
bids_data.to_csv('bids_dummy.csv', index=False)