
# A Database Design and SQL Analysis for a Used Car Online Marketplace 🚙

The used car advertising company requires a database to be connected to its website. The design of the relational database can store and retrieve data such as the list of cars, car information, seller information, and bidding activities.

## 🧐 Project Features & Scope

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

## 🎯 Mission Statements

    👤 User can input their personal info
    🚘 System will manage the car list
    🦾 User can manage their car ads
    💰 Buyer can sending bid price to user


## 📝 Table Structures
| Table Name | Description                                                                  |
|------------|------------------------------------------------------------------------------|
| users      | Store user/seller personal information                                       |
| cities     | Stores information for the city                                              |
| cars       | Stores detailed information about the car                                    |
| car_brands | Store information for all existing car brands                                |
| ads        | Store information for detailed car advertisements managed by the user/seller |
| bids       | Store information for detailed price offers by potential buyers              |

#### Cities Table
The `cities` table will store information about cities, such as id, city_name, location which includes (latitude, and longitude).
| Column Attribute         | Description                      | Business Rules  |
|--------------------------|----------------------------------|-----------------|
| city_id: INT             | Store id of the city             | NOT NULL PK     |
| city_name: VARCHAR(100)  | Stores city name information     | NOT NULL        |
| location: POINT          | Stores the latitude & longitude of the city  | NOT NULL |

Then execute this DDL code to the database:
```sql
CREATE TABLE cities(
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    location POINT NOT NULL
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
The `cars` table will store information about basic car specifications, such as id, brand id, model, body type, fuel type, and year of manufacture. A foreign key constraint will be added to the brand id field, relating to the `car_brands` table.
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
The `ads` table will store information about the list of car advertisements. It will include fields such as ad id, car id, user id, ad title, description, ad status, negotiable status, post date, and additional information about the car being sold. A CHECK constraint will be applied to the price field to prevent negative values. Additionally, foreign key constraints will be added to the user id and car id fields, relating to the `users` and `cars` tables, respectively.
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
The `bids` table will store information about bidding activities if the ad's negotiable status is set to TRUE. It will include fields such as id, buyer id, ad id, bid price, bid date, and bid status. A foreign key constraint will be used on the ad_id field, relating to the `ads` table.
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

![ERD](https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/ER%20Diagram.jpg)


## 🤖 Create and Import Dummy Data to the Database

To generate dummy data, I have prepared a Python script called `dummy_generator.py`. Before using it, there are additional libraries that you need to install in your environment, such as Faker. You can also modify the required data size as needed.

After successfully generating the data, the next step is to insert the data into the database using the Python script `insert_to_db.py`. Before running it, it is recommended to configure the database credentials such as password, etc. in the `env_config.py` file and install the psycopg2 library.

If you want to try it out (generate data then import data to the database), you can run it locally by following these steps:

Clone the project

```bash
  git clone https://github.com/dickyalsyah/used-car-online-marketplace.git
```

Go to the project directory

```bash
  cd my-project
```

Using environment default

```bash
  conda env create -f environment.yml
```

Activate the environment

```bash
  conda activate env
```

Run main script

```bash
  python main.py
```


## 🧪 Test and Retrive Data 

### Transactional Query 🛍️


#### Case 1:
Searching for cars produced from 2015 and above.
```sql
SELECT
	ads.car_id
	, cb.brand_name
	, c.model
	, c.year_manufacture
	, ads.price
FROM ads
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
WHERE c.year_manufacture >= 2015
ORDER BY 5;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Transactional%201.png"> 
</p>

#### Case 2:
Adding a new bid data for a new product.
```sql
BEGIN;
INSERT INTO bids (bid_id, buyer_id, ad_id, bid_date, bid_price)
VALUES (301, 15, 59, '2023-06-25', 290500000);
COMMIT;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Transactional%202.png"> 
</p>

#### Case 3:
Viewing all cars sold by one account, starting from the newest ones.
```sql
SELECT
	ads.car_id
	, cb.brand_name
	, c.model
	, c.year_manufacture
	, ads.price
	, ads.post_date
FROM ads
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
JOIN users u USING(user_id)
WHERE ads.user_id IN (
	SELECT MAX(user_id)
	FROM users
);
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Transactional%203.png"> 
</p>

#### Case 4:
Searching for the cheapest used cars based on a keyword. For example find on Yaris.
```sql
SELECT ads.ad_id, cb.brand_name, c.model, c.year_manufacture, ads.price
FROM cars c
JOIN car_brands cb USING(brand_id)
JOIN ads USING(car_id)
WHERE c.model LIKE '%Yaris%'
ORDER BY ads.price;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Transactional%204.png"> 
</p>

#### Case 5:
Searching for the nearest used cars based on a city ID, where the closest distance is calculated using the Euclidean distance formula based on latitude and longitude.
```sql
CREATE OR REPLACE FUNCTION euclidean_distance(point1 POINT, point2 POINT) 
RETURNS FLOAT AS $$
DECLARE
	lon1 FLOAT := point1[0];
	lat1 FLOAT := point1[1];
	lon2 FLOAT := point2[0];
	lat2 FLOAT := point2[1];
	distance FLOAT;
BEGIN
	-- Euclidean distance formula
	distance := SQRT(POWER(lat1 - lat2, 2) + POWER(lon1 - lon2, 2));
	RETURN distance;
END;
$$ LANGUAGE plpgsql;

SELECT 
	a.user_id
	, a.car_id
	, cb.brand_name
	, c.model
	, c.year_manufacture
	, a.price
    , euclidean_distance(
		(city.location), '(-6.145569,106.838368)'::POINT) AS distance
FROM cars c
JOIN car_brands cb ON c.brand_id = cb.brand_id
JOIN ads a ON c.car_id = a.car_id
JOIN users u ON a.user_id = u.user_id
JOIN cities city ON u.city_id = city.city_id
ORDER BY distance ASC
LIMIT 5;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Transactional%205.png"> 
</p>

### Analytical Query 📊

#### Case 1:
Ranking the popularity of car models based on the number of bids.
```sql
WITH bids_rank AS (
	SELECT
		c.model
		, COUNT(b.bid_id) AS count_bid
	FROM bids b
	JOIN ads USING(ad_id)
	JOIN cars c USING(car_id)
	GROUP BY 1
)
SELECT
	c.model
	, COUNT(a.ad_id) AS count_product
	, count_bid
FROM ads a
JOIN cars c USING(car_id)
JOIN bids_rank USING(model)
GROUP BY 1, 3
ORDER BY 3 DESC;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Analytic%201.png"> 
</p>

#### Case 2:
Comparing car prices based on the average price per city.
```sql
SELECT
	ci.city_name
	, cb.brand_name
	, c.model
	, c.year_manufacture
	, a.price
	, ROUND(AVG(a.price) OVER(PARTITION BY ci.city_name)) AS avg_car_price_per_city
FROM ads a
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
JOIN users u USING(user_id)
JOIN cities ci USING(city_id);
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Analytic%202.png"> 
</p>

#### Case 3:
From the bids for a specific car model, find the comparison of dates when users placed bids with the next bid and the offered bid price. For example, bids for the Toyota car model.
```sql
SELECT
    model,
    buyer_id,
    first_bid_date,
    next_bid_date,
    first_bid_price,
    next_bid_price
FROM (
    SELECT
        model,
        buyer_id,
        bid_date AS first_bid_date,
        LEAD(bid_date) OVER(PARTITION BY buyer_id ORDER BY bid_date) AS next_bid_date,
        bid_price AS first_bid_price,
        LEAD(bid_price) OVER(PARTITION BY buyer_id ORDER BY bid_date) AS next_bid_price,
        ROW_NUMBER() OVER(PARTITION BY buyer_id ORDER BY bid_date) AS rn
    FROM (
        SELECT
            c.model,
            b.buyer_id,
            b.bid_date,
            b.bid_price
        FROM bids b
        JOIN ads a USING(ad_id)
        JOIN cars c USING(car_id)
        WHERE c.model LIKE '%Yaris%'
    ) subquery1
) subquery2
WHERE rn = 1
ORDER BY next_bid_date;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Analytic%203.png"> 
</p>

#### Case 4:
Comparing the percentage difference in average car prices based on their models and the average bid prices offered by customers in the last 6 months.
```sql
SELECT
	c.model
	, ROUND(AVG(a.price)) AS avg_price
	, avgb.avg_bid_6month
	, ROUND(AVG(a.price) - avgb.avg_bid_6month) AS difference
	, ROUND(((AVG(a.price) - avgb.avg_bid_6month)/AVG(a.price))*100, 2) AS difference_percent
FROM cars c
JOIN (
	SELECT
		c.model
		, ROUND(AVG(b.bid_price)) AS avg_bid_6month
	FROM bids b
	JOIN ads a USING(ad_id)
	JOIN cars c USING(car_id)
	WHERE b.bid_date >= CURRENT_DATE - INTERVAL '6 months'
	GROUP BY 1) avgb USING(model)
JOIN ads a USING(car_id)
GROUP BY 1,3;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Analytic%204.png"> 
</p>

#### Case 5:
Creating a window function for the average bid price of a brand and car model over the last 6 months. For example, searching for Toyota Civic cars in the last 6 months.
```sql
SELECT
	cb.brand_name
	, c.model
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months' THEN b.bid_price END),0),0) AS m_avg_6
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '5 months' THEN b.bid_price END),0),0) AS m_avg_5
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '4 months' THEN b.bid_price END),0),0) AS m_avg_4
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 months' THEN b.bid_price END),0),0) AS m_avg_3
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 months' THEN b.bid_price END),0),0) AS m_avg_2
	, ROUND(COALESCE(AVG(CASE WHEN b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 months' THEN b.bid_price END),0),0) AS m_avg_1
FROM bids b
JOIN ads a USING(ad_id)
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
WHERE
    b.bid_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months'
	AND c.model LIKE '%Brio%'
GROUP BY 1,2
ORDER BY 1;
```
<p align="center" width="100%">
    <img src="https://github.com/dickyalsyah/used-car-online-marketplace/blob/main/img/Analytic%205.png"> 
</p>


## References

[Designing a relationship database by Craig Dickson](https://towardsdatascience.com/designing-a-relational-database-and-creating-an-entity-relationship-diagram-89c1c19320b2)


## 🔗 Follow me
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://dickyalsyah.com/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/dickyalsyah)
[![twitter](https://img.shields.io/badge/twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/dickyalsyah)