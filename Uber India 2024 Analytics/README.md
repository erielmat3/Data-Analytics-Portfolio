# Uber India 2024 Analytics

**Code:** [`Uber India 2024 Analytics (Python).ipynb`](./Uber%20India%202024%20Analytics%20(Python).ipynb)

**Interactive Dashboard File (Tableau):** [`Uber India 2024 Analytics.twbx`](./Uber%20India%202024%20Analytics.twbx)

**Dashboard Example (Static):** [`Uber India 2024 Dashboard (Operations).png`](./Uber%20India%202024%20Dashboard%20(Operations).png)

## Overview
The objective of this project was to analyze Uber's performance in India in 2024 by 2 aspects, which are User and Operational Performance. The analysis done in this project is limited to diagnostic analytics only.

## Dataset
The dataset used in this project was retrieved from Kaggle, which can be found here: [`Uber Bookings Dataset.csv`](./ncr_ride_bookings.csv)
- Period: 1 Jan 2024 - 31 Dec 2024 (150.000 rows)
- Size: 150.000 rows x 21 columns

## Tools
- **Python (Pandas, Matplotlib, Seaborn, Numpy)**: For data cleaning & pre-processing
- **Excel**: For data storing and some cleaning

## Methodology
1. Library Setup
2. Data Reading
3. Data Cleaning
4. Exploratory Data Analysis & Insight Generation
5. Dashboard

## Result
### Key Takeaways
- **Most of the trips took around 15-45 minutes to arrive at the destination point after pickup** on average, which indicates medium-distance travel.
- **Approximately 1 of 5 orders were cancelled by drivers**, which is relatively high.
- **Only 30% of all trips gained driver ratings of 4.5 and above**, which is relatively low because many platforms expect driver ratings to be above 4.6.
- **Unified Payments Interface (UPI) and Cash were payment methods that customers used most**, indicating that these were perceived as the most convenient options.
- 3 vehicle types: **Auto, Go Mini, and Go Sedan**, accounted for around 62.9% of all bookings in 2024, **making them the core business of Uber in India**.

### Business Recommendations
- **Design promotions for medium-distance commuters.**
- **Implement pre-screening features to minimize the risk of cancellations due to health-related reasons**, as it accounted for 25% of the driver-cancelled rides.
- **Set a minimum rating threshold for drivers** (with the possibility of suspension if it fell below the limit) that may push their motivation to further improve their performance
- **Offer discounts, promotions, or loyalty rewards based on UPI and Cash** payment methods to boost transaction volume.
- **Improve driver quality & unit availability** for these 3 services, and **offer vouchers or discounts** to maintain large market share.

You can check the interactive dashboard in the .twbx file provided, or in this [Tableau Public Link](https://public.tableau.com/views/UberIndia2024Analytics/Operations?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

