-- Create cities table with UNIQUE constraint in latitude and longitude
CREATE TABLE cities(
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    latitude NUMERIC(9,6) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    CONSTRAINT uc_latlong UNIQUE (latitude, longitude)
);

-- Create table users with UNIQUE constraint in phone_number and ADD FK in city_id ON DELETE RETRICT
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    city_id INT NOT NULL,
    zip_code SMALLINT,
    CONSTRAINT us_phone_number UNIQUE (phone_number),
    CONSTRAINT fk_city_id FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE RESTRICT
);

-- Create table car_brands with UNIQUE constraint in brand_name
CREATE TABLE car_brands(
    brand_id SERIAL PRIMARY KEY,
    brand_name VARCHAR(225) NOT NULL,
    CONSTRAINT ucb_brand_name UNIQUE (brand_name)
);

-- Create table cars with FK constraint in brand_id ON DELETE RETRICT
CREATE TABLE cars(
    car_id SERIAL PRIMARY KEY,
    brand_id INT NOT NULL,
    model VARCHAR(225) NOT NULL,
    body_type VARCHAR(50) NOT NULL,
    fuel_type VARCHAR(50) NOT NULL,
    year_manufacture SMALLINT NOT NULL,
    CONSTRAINT fk_brand_id FOREIGN KEY (brand_id) REFERENCES car_brands(brand_id) ON DELETE RESTRICT
);

-- Create table ads with FK constraint in user_id and car_id ON DELETE NO ACTION, also check price non-negative value
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
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE NO ACTION,
    CONSTRAINT fk_car_id FOREIGN KEY (car_id) REFERENCES cars(car_id) ON DELETE NO ACTION
);

-- Create table bids with FK constraint in ad_id ON DELETE NO ACTION
CREATE TABLE bids(
    bid_id SERIAL PRIMARY KEY,
    buyer_id INT NOT NULL,
    ad_id INT NOT NULL,
    bid_price NUMERIC NOT NULL,
    bid_date DATE NOT NULL,
    bid_status VARCHAR(20) NOT NULL DEFAULT 'Dikirim',
    CONSTRAINT fk_ad_id FOREIGN KEY (ad_id) REFERENCES ads(ad_id) ON DELETE NO ACTION
);

-- Create index on model in cars table for performance tuning
CREATE INDEX idx_model_car
ON cars USING btree(model);