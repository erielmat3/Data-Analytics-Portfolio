SELECT *
FROM website_sessions;

-- Case Traffic Source (Page 8)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-13'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;
-- DONE

-- Case Trend Analysis of Top Traffic Source (Page 12)
SELECT utm_source, utm_campaign, http_referer, COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-04-15' AND '2012-05-11'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY COUNT(website_session_id) DESC;
-- DONE

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
---- DONE

---- Case Repeat Channel Behaviour Analysis (Page 17)
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
---- DONE