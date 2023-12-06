-- Ranking popularitas model mobil berdasarkan jumlah bid
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
ORDER BY 2 DESC;

-- Membandingkan harga mobil berdasarkan harga rata-rata per kota
SELECT
	ci.city_name
	, cb.brand_name
	, c.model
	, c.year_manufacture
	, ROUND(AVG(a.price),0) as avg_car_price
FROM ads a
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
JOIN users u USING(user_id)
JOIN cities ci USING(city_id)
GROUP BY 1,2,3,4;

-- Dari penawaran suatu model mobil, cari perbandingan tanggal user melakukan bid dengan bid 
-- selanjutnya beserta harga tawar yang diberikan
SELECT
    r1.model,
    r1.buyer_id,
    r1.bid_date AS first_bid_date,
    r2.bid_date AS next_bid_date,
    r1.bid_price AS first_bid_price,
    r2.bid_price AS next_bid_price
FROM (
    SELECT
        c.model,
        b.buyer_id,
        b.bid_date,
        b.bid_price,
        ROW_NUMBER() OVER(PARTITION BY c.model, b.buyer_id ORDER BY b.bid_date) AS rn
    FROM bids b
    JOIN ads a USING(ad_id)
    JOIN cars c USING(car_id)
) r1
JOIN (
    SELECT
        c.model,
        b.buyer_id,
        b.bid_date,
        b.bid_price,
        ROW_NUMBER() OVER(PARTITION BY c.model, b.buyer_id ORDER BY b.bid_date) AS rn
    FROM bids b
    JOIN ads a USING(ad_id)
    JOIN cars c USING(car_id)
) r2 ON r1.model = r2.model AND r1.buyer_id = r2.buyer_id
WHERE r1.rn = 1 AND r2.rn = 2;

-- Membandingkan persentase perbedaan rata-rata harga mobil berdasarkan modelnya dan 
-- rata-rata harga bid yang ditawarkan oleh customer pada 6 bulan terakhir
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

-- Membuat window function rata-rata harga bid sebuah merk dan model mobil selama 6 bulan terakhir
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
GROUP BY 1,2
ORDER BY 1;

-- VALIDATE
SELECT
	cb.brand_name
    , c.model
	, AVG(b.bid_price)
FROM bids b
JOIN ads a USING(ad_id)
JOIN cars c USING(car_id)
JOIN car_brands cb USING(brand_id)
WHERE b.bid_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY 1,2
ORDER BY 1;