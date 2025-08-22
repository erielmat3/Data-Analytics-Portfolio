# Wine Type Classification
**Code:** [`Wine Classification with K-Nearest Neighbors.ipynb`](./Wine%20Classification%20with%20K-Nearest%20Neighbors.ipynb)

This is my first data analytics portfolio. The objective of this project is **to construct a machine learning classifier that can classify 3 different wine types with high accuracy based on its constituents.**

## Dataset Information
The dataset used in this project was obtained from the UC Irvine Machine Learning Repository, which contains informations about 13 constituents of 3 different wine types grown in the same region in Italy, but derived from three different cultivars. There are 13 features in this dataset, with 1 target variable, and 178 data points. 

**The complete dataset can be found here:** [`Wine Dataset.csv`](./Wine%20Dataset.csv)

## Tools & Libraries
- Python (Pandas, Matplotlib, Seaborn, Scikit-learn)

## Methodology
1. Setup (Library Preparation)
2. Data Reading
3. Dataset Splitting
4. Exploratory Data Analysis
5. Data Preprocessing
6. Model Training
7. Hyperparameter Tuning
8. Model Evaluation

## Result
Based on the analysis conducted, two key insights can be drawn:
- Through data exploration, we can infer that certain types of wine possessed different characteristics compared to others. For example, Wine Type '1' tend to have a higher alcohol level than other types. Meanwhile, Wine Type '2' generally showed a lower color intensity value, suggesting that it may have a paler appearance.
- The classification model built using the K-Nearest Neighbors (KNN) algorithm was able to accurately classify wine types based on their composition, achieving an accuracy level of up to 97.78%.

**A more detailed explanation of this project can be found in the following file:** [`Wine Classification with K-Nearest Neighbors.pdf`](./Wine%20Classification%20with%20K-Nearest%20Neighbors.pdf)
