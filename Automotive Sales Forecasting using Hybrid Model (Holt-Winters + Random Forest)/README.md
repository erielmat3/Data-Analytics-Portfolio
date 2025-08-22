# Automotive Sales Forecasting
**Code:** [Automotive Sales Forecasting.ipynb](./Automotive Sales Forecasting using Hybrid Model (Holt-Winters + Random Forest)/Automotive Sales Forecasting.ipynb)

The objective of this project was to build a sales forecasting model to predict the monthly demand of a Multi-Purpose Vehicle Product at a dealership in Malang City, Indonesia, in order to address the **issue of underachieving** monthly sales target caused by **unrealistic goal-setting** that did not take market dynamics and macroeconomic factors into account. Sales forecasting can assist stakeholders in gaining insights into realistic sales projections, serving as a basis for setting sales targets.

To maintain data confidentiality, the product name is referred to as Product X, the dealership as Dealer U, and the company as Company Z.

## Dataset
- Period: Jan 2014 - Feb 2025 (134 datapoints)
- Variables: Month, Macroeconomic factors (Inflation Rate, CPI), Online search data from Google Trends (related to Product X, price of Product X, and Company Z)
- Size: 134 rows x 9 columns

**The original dataset used in this project is not included here to maintain data confidentiality**

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

## Result
The application of a hybrid model was able to improve the forecasting result by reducing the in-sample dan out-of-sample **performance gap by 83.43%*, indicating a better generalization ability**. In addition, this hybrid model also enhanced the in-sample and out-of-sample performance **by 42.9% and 13.2%**, respectively. **These comparisons were made between the hybrid model and the standalone Holt-Winters' model.**

## Conclusion
By using a comprehensive forecasting model, the corresponding dealership is now able to set realistic sales targets that take into account real market dynamics.
