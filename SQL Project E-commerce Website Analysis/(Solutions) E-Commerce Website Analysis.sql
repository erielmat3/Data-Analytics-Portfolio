-- Reviewed all tables in the database to understand each of them. LIMIT is used to ensure query efficiency.
SELECT *
FROM website_sessions
LIMIT 1000;

SELECT *
FROM website_pageviews
LIMIT 1000;

SELECT *
FROM orders
LIMIT 1000;

SELECT *
FROM order_items
LIMIT 1000;

SELECT *
FROM order_item_refunds
LIMIT 1000;

SELECT *
FROM products
LIMIT 1000;

-- Question 1 (Traffic details prior to April 13, 2012, based on UTM source, campaign, and HTTP referer)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-13'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;

-- Question 2 (Conversion rate prior to April 14, 2012)
SELECT ws.utm_source, ws.utm_campaign, 
	   COUNT(ws.website_session_id) AS sessions, COUNT(o.order_id) AS order_count,
	   (CAST((COUNT(o.order_id)*100) AS DECIMAL(10,4)) / CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4))) AS session_to_order_cvr
FROM orders o
RIGHT JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-04-13' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY ws.utm_source, ws.utm_campaign;

-- Question 3 (Weekly session volulme after change in marketing budget)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-05-11'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;

-- Question 4 (Conversion rate based on device type prior to May 12, 2012)
SELECT ws.device_type, 
	   COUNT(ws.website_session_id) AS sessions, COUNT(o.order_id) AS order_count,
	   (CAST((COUNT(o.order_id)*100) AS DECIMAL(10,4)) / CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4))) AS session_to_order_cvr
FROM orders o
RIGHT JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-05-12' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY 1;

-- Question 5 (Page with the highest number of sessions until June 10, 2012)
SELECT pageview_url, COUNT(website_pageview_id) AS sessions
FROM website_pageviews
WHERE created_at < '2012-06-10'
GROUP BY pageview_url
ORDER BY COUNT(website_pageview_id) DESC;

-- Question 6 (Frequently accessed landing page by users upon entering website until June 13, 2012)
SELECT pageview_url, COUNT(website_pageview_id) AS sessions
FROM website_pageviews
WHERE created_at < '2012-06-13'
GROUP BY pageview_url
ORDER BY COUNT(website_pageview_id) DESC
LIMIT 1;

-- Question 7 (Analysis of monthly trends in sales, revenue, and profit, until January 5, 2013)
SELECT 
	EXTRACT(MONTH FROM created_at) AS month_created_at, EXTRACT(YEAR FROM created_at) AS year_created_at,
	SUM(items_purchased) AS amount_sold,
	(SUM(items_purchased)*49.99) AS revenue,
	(SUM(items_purchased)*19.49) AS capital,
	(SUM(items_purchased)*49.99 - SUM(items_purchased)*19.49) AS profit
FROM orders
WHERE created_at < '2013-01-05'
GROUP BY 1, 2
ORDER BY 2, 1;

-- Question 8 (Analysis of monthly order volume, conversion rate, and sales for each product, from April 1, 2012, to April 5, 2013)
WITH cvr_table AS(
	SELECT 
		EXTRACT(MONTH FROM ws.created_at) AS month_created_at, 
		EXTRACT(YEAR FROM ws.created_at) AS year_created_at,
		COUNT(ws.website_session_id) AS sessions,
		COUNT(o.order_id) AS order_count,
		(CAST((COUNT(o.order_id)*100) AS DECIMAL(10,4))/CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4))) AS cvr
	FROM orders o
		RIGHT JOIN website_sessions ws
			USING(website_session_id)
	WHERE ws.created_at BETWEEN '2012-04-01' AND '2013-04-05'
	GROUP BY 1, 2
	ORDER BY 2, 1
),
product_1_sales AS(
	SELECT
		EXTRACT(MONTH FROM created_at) AS month_created_at, 
		EXTRACT(YEAR FROM created_at) AS year_created_at,
		primary_product_id,
		SUM(items_purchased) AS product_1_sold
	FROM orders
	WHERE created_at BETWEEN '2012-04-01' AND '2013-04-05'
	GROUP BY 1, 2, 3
	HAVING primary_product_id = 1
	ORDER BY 2, 1
),
product_2_sales AS(
	SELECT
		EXTRACT(MONTH FROM created_at) AS month_created_at, 
		EXTRACT(YEAR FROM created_at) AS year_created_at,
		primary_product_id,
		SUM(items_purchased) AS product_2_sold
	FROM orders
	WHERE created_at BETWEEN '2012-04-01' AND '2013-04-05'
	GROUP BY 1, 2, 3
	HAVING primary_product_id = 2
	ORDER BY 2, 1
)
SELECT 
	cvr.month_created_at, 
	cvr.year_created_at, 
	cvr.sessions,
	cvr.order_count,
	cvr.cvr,
	s1.product_1_sold, 
	COALESCE(s2.product_2_sold, 0) AS product_2_sold
FROM cvr_table cvr
	LEFT JOIN product_1_sales s1
		USING(month_created_at, year_created_at)
	LEFT JOIN product_2_sales s2
		USING(month_created_at, year_created_at);

-- Question 9 (Number of cross-selling products sold for each primary product purchased, from 25 Septmber, 2013, to 31 December, 2013)
SELECT 
	o.primary_product_id,
	COUNT(DISTINCT o.order_id) AS order_count,
	COUNT(CASE WHEN oi.product_id = 1 AND oi.is_primary_item = 0 THEN 1 ELSE NULL END) AS xsell_p1,
	COUNT(CASE WHEN oi.product_id = 2 AND oi.is_primary_item = 0 THEN 1 ELSE NULL END) AS xsell_p2,
	COUNT(CASE WHEN oi.product_id = 3 AND oi.is_primary_item = 0 THEN 1 ELSE NULL END) AS xsell_p3
FROM orders o
	JOIN order_items oi
		ON o.order_id = oi.order_id
WHERE o.created_at BETWEEN '2013-09-25' AND '2013-12-31'
GROUP BY 1
ORDER BY 1;

-- Question 10 (Number of users who returned to visit the website)
SELECT 
	repeat_sessions,
	COUNT(repeat_sessions) AS users
FROM(
	SELECT 
		user_id, 
		SUM(is_repeat_session) AS repeat_sessions
	FROM website_sessions
	WHERE created_at < '2014-06-01'
	GROUP BY 1
	ORDER BY 2, 1
)
GROUP BY repeat_sessions;

-- Question 11 (Comparison of the number of new and repeat sessions by channel)
SELECT 
	CASE 
		WHEN utm_campaign='brand' THEN 'paid_brand'
		WHEN utm_campaign='nonbrand' THEN 'paid_nonbrand'
		WHEN utm_source='socialbook' THEN 'paid_social'
		WHEN http_referer IS NULL THEN 'direct_type_in'
		ELSE 'organic_search'
	END AS channel_group,
	COUNT(CASE WHEN is_repeat_session = 0 THEN 1 ELSE NULL END) AS new_session,
	COUNT(CASE WHEN is_repeat_session = 1 THEN 1 ELSE NULL END) AS repeat_session
FROM website_sessions
WHERE created_at < '2014-06-08'
GROUP BY 1
ORDER BY 2 DESC;

-- Question 12 (Conversion rate comparison between new sessions and repeat sessions, from the year of 2014)
SELECT 
	ws.is_repeat_session,
	COUNT(ws.website_session_id) AS sessions,
	COUNT(o.order_id) AS orders,
	CAST(COUNT(o.order_id)*100 AS DECIMAL(10,4))/CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4)) AS cvr
FROM orders o
	RIGHT JOIN website_sessions ws
		ON o.website_session_id = ws.website_session_id
WHERE ws.created_at BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY 1;
