# SQL Questions (E-Commerce Website Analysis)

## Database Description:
This database contains data from a fictitious company with the following tables:
- `website_sessions(website_session_id, created_at, user_id, is_repeat_session, utm_source, utm_campaign, utm_content, device_type, http_referer)`
- `website_pageviews(website_pageview_id, created_at, website_session_id, pageview_url)`
- `orders(order_id, created_at, website_session_id, user_id, primary_product_id, item_purchased, price_usd, cogs_usd)`
- `order_items(order_item_id, created_at, order_id, product_id, is_primary_item, price_usd, cogs_usd)`
- `order_item_refunds(order_item_refund_id, created_at, order_item_id, order_id, refund_amount_usd)`
- `products(product_id, created_at, product_name)`

## Questions
1. The company wanted to view the **traffic details prior to April 13, 2012** based on **UTM source**, **UTM campaign**, dan **HTTP referer**

2. On **April 14, 2012**, the company asked you to **calculate the conversion rate (CVR) from session to order**. They required a **minimum CVR of 5%** in order **to decide whether to increase the advertising budget** for the 'gsearch non-brand' channel.

3. On **May 11, 2012**, the company requested an **analysis of the weekly session volume trend**. Did the change in the marketing budget cause the overall session volume to decline?

4. The company received feedback from users that those accessing the website via mobile devices frequently encountered errors. Therefore, on **May 12, 2012**, the company requested the **calculation of the conversion rate (session to order) based on the type of device used by the users**. This was conducted to identify opportunities for ad optimization according to the device type.

5. On **June 10, 2012**, the website manager wanted to know **which web page had the highest number of views (sessions) since the website was launched**.

6. On **June 13, 2012**, the website manager wanted to see **which landing page was most frequently viewed or accessed by users upon entering the website**.

7. At the beginning of 2013, the company planned to introduce a new product. On **January 5, 2013**, the company requested an **analysis of the monthly trends in sales, revenue, and margin/profit**.

8. The company launched a new product on January 6, 2013. On **April 5, 2013**, the company requested an **analysis of the monthly order volume, conversion rate, and sales figures for each product (both the existing product and the new product), starting from April 1, 2012**.

9. Since September 25, 2013, the company **implemented a cross-selling strategy to increase sales**. By the end of 2013, they also added one new product, bringing the **total to three products offered on the website**. On **January 2, 2014**, the company requested an **analysis of the cross-sell performance from its launch until the end of 2013, to determine the number of cross-sell products sold with each primary product purchase**.

10. On **June 1, 2014**, the website manager wanted to find out **the number of users who repeated/returned to visit the website**.

11. On **June 8, 2014**, the marketing manager wanted to know **which channels were used by users when returning to the website**, to see whether they came through direct type-in or through the company’s paid campaigns. He requested **a comparison of the number of new and repeat sessions by channel**. (*If http_referer is 'gsearch' or 'bsearch', then it's categorized as **'organic_search'**. If utm_source is 'socialbook', then it's categorized as **'paid_social'**. If utm_campaign is 'nonbrand', then it's categorized as **'paid_nonbrand'**. If utm_campaign is 'brand', then it's categorized as **'paid_brand'**. Else, it's categorized as **'direct_type_in'***)

12. The website manager wanted to assess the **value of repeating customers** for the company by **comparing the conversion rate of new sessions and repeat sessions**. He requested the use of **data from the year 2014**.
