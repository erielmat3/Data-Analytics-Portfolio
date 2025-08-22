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

---- Part 1
-- Case Traffic Source (Page 8)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-13'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;
-- DONE

-- Case Conversion Rate Top Traffic Source (Page 10)
SELECT ws.utm_source, ws.utm_campaign, 
	   COUNT(ws.website_session_id) AS sessions, COUNT(o.order_id) AS order_count,
	   (CAST((COUNT(o.order_id)*100) AS DECIMAL(10,4)) / CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4))) AS session_to_order_cvr
FROM orders o
RIGHT JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-04-13' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY ws.utm_source, ws.utm_campaign;
-- DONE

-- Case Trend Analysis of Top Traffic Source (Page 12)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-05-11'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;
-- DONE

-- Case Bid Optimization for Paid Traffic (Page 14)
SELECT ws.device_type, 
	   COUNT(ws.website_session_id) AS sessions, COUNT(o.order_id) AS order_count,
	   (CAST((COUNT(o.order_id)*100) AS DECIMAL(10,4)) / CAST(COUNT(ws.website_session_id) AS DECIMAL(10,4))) AS session_to_order_cvr
FROM orders o
RIGHT JOIN website_sessions ws
ON o.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-05-12' AND utm_source = 'gsearch' AND utm_campaign = 'nonbrand'
GROUP BY 1;
-- DONE

-- Case Top Website Pages (Page 18)
SELECT pageview_url, COUNT(website_pageview_id) AS sessions
FROM website_pageviews
WHERE created_at < '2012-06-10'
GROUP BY pageview_url
ORDER BY COUNT(website_pageview_id) DESC;
-- DONE

-- Case Top Entry Pages (Page 20) [My Ver]
SELECT pageview_url, COUNT(website_pageview_id) AS sessions
FROM website_pageviews
WHERE created_at < '2012-06-13'
GROUP BY pageview_url
ORDER BY COUNT(website_pageview_id) DESC
LIMIT 1;
-- DONE

---- Part 2
-- Case Trend Analysis (Page 8)
SELECT *
FROM orders
WHERE created_at < '2013-01-05';

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
-- DONE

-- Case Analyzing Effect of New Product (Page 10)
-- Conversion Rate
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
-- Volume Order Bulanan
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
-- DONE

-- Identifying Number of Each Cross-Sell (Page 12)
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
-- DONE

-- Case Identifying Repeat Visitors (Page 15)
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
-- DONE

-- Case Repeat Channel Behaviour Analysis (Page 17)
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
-- DONE

-- Analyzing New and Repeat Conversion Rate (Page 20)
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
-- DONE