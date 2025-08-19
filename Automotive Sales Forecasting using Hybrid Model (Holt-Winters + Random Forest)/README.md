# Automotive Sales Forecasting
The objective of this project was to build a sales forecasting model to predict the monthly demand of a Multi-Purpose Vehicle Product at a dealership in Malang City, Indonesia, in order to address the **issue of underachieving** monthly sales target caused by **unrealistic goal-setting** that did not take market dynamics and macroeconomic factors into account. Sales forecasting can assist stakeholders in gaining insights into realistic sales projections, serving as a basis for setting sales targets.

To maintain data confidentiality, the product name is referred to as Product X, the dealership as Dealer U, and the company as Company Z.

## Dataset
- Period: Jan 2014 - Feb 2025 (134 datapoints)
- Variables: Month, Macroeconomic factors (Inflation Rate, CPI), Online search data from Google Trends (related to Product X, price of Product X, and Company Z)
- Size: 134 rows x 9 columns

## Tools & Libraries
- Python (Pandas, Numpy, Matplotlib, Seaborn, Statsmodels, pmdarima, Scikit-learn)
- Excel (For data storing & preprocessing)

## Methodology
1. Library Preparation
2. Data Collection & Integration
3. Exploratory Data Analysis
4. Holt-Winters' (HW) Model Training + Tuning + Evaluation
5. Random Forest (RF) Model Training + Tuning + Evaluation
6. Hybrid Model Development (Holt-Winters' + Random Forest)
7. 2025 Monthly Sales Forecasting (Mar 2025 - Dec 2025)
