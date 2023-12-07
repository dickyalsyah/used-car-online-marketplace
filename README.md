
# A Database Design and SQL Analysis for a Used Car Online Marketplace 🚙

The used car advertising company requires a database to be connected to its website. The design of the relational database can store and retrieve data such as the list of cars, car information, seller information, and bidding activities.

## Project Features & Scope 🧐

- Each application seller/user can offer more than one of their used car products.
- Before selling a car product, users must first complete their personal data, such as name, contact information, and location.
- Users offer their products through ads that will be displayed on the website.
- These ads include a title, detailed information about the product being offered, and the seller's contact information.
- Some information that should be included in the ads are as follows:
    - Car brand: Toyota, Daihatsu, Honda, etc.
    - Model: Toyota Camry, Toyota Corolla Altis, Toyota Vios, Toyota Camry Hybrid, etc.
    - Car body type: MPV, SUV, Van, Sedan, Hatchback, etc.
    - Car type: manual or automatic.
    - Car manufacturing year: 2005, 2010, 2011, 2020.
    - Additional description, such as color, mileage, etc., can be added as needed.
- Each user can search for offered cars based on the seller's location, car brand, and car body type.
- If a potential buyer is interested in a car, they can bid on the price of the product if the seller allows the bidding feature.
- The purchase transaction is conducted outside the application and is not within the scope of the project.

## Mission Statements 🎯

    👤 User can input their personal info
    🚘 System will manage the car list
    🦾 User can manage their car ads
    💰 Buyer can sending bid price to user


## Table Structures 📝
| Table Name | Description                                                                  |
|------------|------------------------------------------------------------------------------|
| users      | Store user/seller personal information                                       |
| cities     | Stores information for the city                                              |
| cars       | Stores detailed information about the car                                    |
| car_brands | Store information for all existing car brands                                |
| ads        | Store information for detailed car advertisements managed by the user/seller |
| bids       | Store information for detailed price offers by potential buyers              |

#### Cities Table
The `cities` table will store information about cities, such as id, city_name, latitude, and longitude. A unique constraint will be applied to latitude and longitude to ensure that the combination of latitude and longitude is unique.
| Column Attribute         | Description                      | Business Rules  |
|--------------------------|----------------------------------|-----------------|
| city_id: INT             | Store id of the city             | NOT NULL PK     |
| city_name: VARCHAR(100)  | Stores city name information     | NOT NULL        |
| latitude: NUMERIC(9, 6)  | Stores the latitude of the city  | NOT NULL UNIQUE |
| longitude: NUMERIC(9, 6) | Stores the longitude of the city | NOT NULL UNIQUE |

Then execute this DDL code to the database:
```sql
CREATE TABLE cities(
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    CONSTRAINT uc_latlong UNIQUE (latitude, longitude)
);
```

#### Users Table
The `users` table will store information about personal users, such as id, user name, phone number, city id, and zip code. A unique constraint will be added to the phone number field, and a foreign key constraint will be added to the city id field, relating to the `cities` table.
| Column Attribute           | Description                             | Business Rules |
|----------------------------|-----------------------------------------|----------------|
| user_id: SERIAL            | Store the ID of the user data           | NOT NULL PK    |
| name: VARCHAR(225)         | Store the user name                     | NOT NULL       |
| city_id: INT               | Stores the city id where the user lives | NOT NULL FK    |
| phone_number: VARCHAR(100) | Stores phone number of the user         | NOT NULL UNIQUE|
| zip_code: SMALLINT         | Stores user zip code                    |                |

Execute this DDL code to the database:
```sql
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    city_id INT NOT NULL,
    zip_code SMALLINT,
    CONSTRAINT us_phone_number UNIQUE (phone_number)
    CONSTRAINT fk_city_id FOREIGN KEY city_id REFERENCES cities(city_id) ON DELETE RESTRICT
);
```

#### Car Brands Table
The `car_brands` table will be added as a supporting normalization table that will store information about car brands.
| Column Attribute         | Description                   | Business Rules |
|--------------------------|-------------------------------|----------------|
| brand_id: SERIAL         | Store the ID of the car brand | NOT NULL PK    |
| brand_name: VARCHAR(100) | Stores name of the car brand  | NOT NULL UNIQUE|

Execute this DDL code to the database:
```sql
CREATE TABLE car_brands(
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(225) NOT NULL,
    CONSTRAINT ucb_brand_name UNIQUE (brand_name)
);
```
#### Cars Table
| Column Attribute           | Description                                        | Business Rules |
|----------------------------|----------------------------------------------------|----------------|
| car_id: SERIAL             | Store the ID of the car                            | PK             |
| brand_id: INT              | Store the ID of the car brand                      | NOT NULL FK    |
| model: VARCHAR(225)        | Stores the model of the car (Toyota Alphard, etc)  | NOT NULL       |
| body_type: VARCHAR(50)     | Stores the body type of the car (Sedan, Hatchback) | NOT NULL       |
| fuel_type: VARCHAR(50)     | Stores the fuel type (Bensin, Solar, Listrik)      | NOT NULL       |
| year_manufacture: SMALLINT | Stores the year of manufacture of the car          | NOT NULL       |

Execute this DDL code to the database:
```sql
CREATE TABLE cars(
    car_id SERIAL PRIMARY KEY,
    brand_id INT NOT NULL,
    model VARCHAR(225) NOT NULL,
    body_type VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(50) NOT NULL,
    year_manufacture SMALLINT NOT NULL,
    CONSTRAINT fk_brand_id FOREIGN KEY brand_id REFERENCES car_brands(brand_id) ON DELETE RESTRICT
);
```

#### Ads Table
| Column Attribute          | Description                                                     | Business Rules        |
|---------------------------|-----------------------------------------------------------------|-----------------------|
| ad_id: SERIAL             | Stores advertisement ID                                         | NOT NULL PK           |
| user_id: INT              | Store the ID of the user data                                   | NOT NULL FK           |
| car_id: INT               | Store the ID of the car                                         | NOT NULL FK           |
| title: VARCHAR(225)       | Stores ad title information                                     | NOT NULL              |
| description: TEXT         | Stores ad description information                               |                       |
| mileage_km: INT           | Stores milleage km information from the car                     | NOT NULL              |
| color: VARCHAR(50)        | Stores color of the car                                         | NOT NULL              |
| transmission: VARCHAR(20) | Stores transmission type of the car (Manual/Auto)               | NOT NULL              |
| price: NUMERIC            | Store car price information                                     | NOT NULL CHECK >= 0   |
| status: BOOLEAN           | Stores information whether the ad is still active or not        | NOT NULL DEFAULT TRUE |
| negotiable: BOOLEAN       | Stores information about whether the price is negotiable or not | NOT NULL DEFAULT TRUE |
| post_date: DATE           | Store information when the ad was posted                        | NOT NULL              |

Execute this DDL code to the database:
```sql
CREATE TABLE ads(
    ad_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    car_id INT NOT NULL,
    title VARCHAR(225) NOT NULL,
    description TEXT,
    mileage_km INT NOT NULL,
    color VARCHAR(50) NOT NULL,
    transmission VARCHAR(50) NOT NULL,
    price NUMERIC NOT NULL,
    ad_status BOOLEAN NOT NULL DEFAULT TRUE,
    negotiable BOOLEAN NOT NULL DEFAULT TRUE,
    post_date DATE NOT NULL,
    CONSTRAINT ch_price CHECK (price >= 0),
    CONSTRAINT fk_user_id FOREIGN KEY user_id REFERENCES users(user_id) ON DELETE NO ACTION,
    CONSTRAINT fk_car_id FOREIGN KEY car_id REFERENCES cars(car_id) ON DELETE NO ACTION
);
```

#### Bids Table
| Column Attribute        | Description                                                         | Business Rules             |
|-------------------------|---------------------------------------------------------------------|----------------------------|
| bid_id: SERIAL          | Stores bid ID information                                           | NOT NULL PK                |
| buyer_id: INT           | Stores buyer ID                                                     | NOT NULL                   |
| ad_id: INT              | Stores advertisement ID                                             | NOT NULL FK                |
| bid_price: NUMERIC      | Stores bid price information                                        | NOT NULL                   |
| bid_date: DATE          | Store information on the date when the bid was sent                 | NOT NULL                   |
| bid_status: VARCHAR(20) | Save status information from sent bids (Dikirim, Diterima, Ditolak) | NOT NULL DEFAULT 'Dikirim' |

Execute this DDL code to the database:
```sql
CREATE TABLE bids(
    bid_id SERIAL PRIMARY KEY,
    buyer_id INT NOT NULL,
    ad_id INT NOT NULL,
    bid_price NUMERIC NOT NULL,
    bid_date DATE NOT NULL,
    bid_status VARCHAR(20) NOT NULL DEFAULT 'Dikirim',
    CONSTRAINT fk_ad_id FOREIGN KEY ad_id REFERENCES ads(ad_id) ON DELETE NO ACTION,
);
```
![ERD](https://i.ibb.co/BjVPLwg/ER-Diagram.jpg)

<img src="https://i.ibb.co/BjVPLwg/ER-Diagram.jpg" alt="ER-Diagram" border="0">

![ERD](https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/ER%20Diagram.jpg)



## Run Locally

Clone the project

```bash
  git clone https://link-to-project
```

Go to the project directory

```bash
  cd my-project
```

Install dependencies

```bash
  npm install
```

Start the server

```bash
  npm run start
```

