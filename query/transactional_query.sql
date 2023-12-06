-- Mencari mobil keluaran 2015 ke atas
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

-- Menambahkan satu data bid produk baru
BEGIN;
INSERT INTO bids (bid_id, buyer_id, ad_id, bid_date, bid_price)
VALUES (301, 15, 59, '2023-06-25', 290500000);
COMMIT;

-- Cek data yang baru saja ditambahkan
SELECT *
FROM (
  	SELECT *
	FROM bids
	ORDER BY bid_id DESC
	LIMIT 5
) AS last_five_rows
ORDER BY bid_id ASC;

-- Melihat semua mobil yg dijual 1 akun dari yg paling baru
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

-- Mencari mobil bekas yang termurah berdasarkan keyword
SELECT ads.ad_id, cb.brand_name, c.model, c.year_manufacture, ads.price
FROM cars c
JOIN car_brands cb USING(brand_id)
JOIN ads USING(car_id)
WHERE c.model LIKE '%Yaris%';

-- Mencari mobil bekas yang terdekat berdasarkan sebuah id kota, jarak terdekat dihitung berdasarkan latitude longitude.
-- Perhitungan jarak dapat dihitung menggunakan rumus jarak euclidean berdasarkan latitude dan longitude.
SELECT a.user_id, a.car_id, cb.brand_name, c.model, c.year_manufacture, a.price,
    SQRT(POWER(city.latitude - (-6.145569), 2) + POWER(city.longitude - (106.838368), 2)) AS distance
FROM cars c
JOIN car_brands cb ON c.brand_id = cb.brand_id
JOIN ads a ON c.car_id = a.car_id
JOIN users u ON a.user_id = u.user_id
JOIN cities city ON u.city_id = city.city_id
ORDER BY distance ASC
LIMIT 5;