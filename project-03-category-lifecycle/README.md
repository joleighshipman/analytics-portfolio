# Project 03: Category Lifecycle & Opportunity Analysis

## Project Overview

This project examines historical product category performance using the Brazilian Olist e-commerce dataset. The analysis combines SQL-based performance metrics, Python feature preparation and K-Means clustering, and Power BI visualizations to evaluate category scale, activity, historical growth consistency, and commercial opportunity.

## Business Objective

Identify distinct product category performance patterns and evaluate how established, lower-activity, and emerging categories differ across key commercial metrics.

## Tools & Technologies

- SQL
- Python
- Pandas and NumPy
- Scikit-learn
- Matplotlib and Seaborn
- Power BI

## Analytical Approach

### 1. SQL Performance Analysis
- Aggregated monthly category revenue, order volume, and units sold.
- Evaluated category activity across the 25-month observation period.
- Calculated historical growth consistency.
- Developed a rule-based opportunity scoring framework.

### 2. Python Clustering Analysis
- Prepared five numerical category performance features.
- Standardized features using StandardScaler.
- Evaluated K-Means solutions across two to ten clusters.
- Selected a four-cluster solution based on the highest silhouette score among the tested configurations.

### 3. Power BI Visualization
Developed dashboards to communicate category performance, lifecycle patterns, and commercial opportunity.

## Key Findings

- **Cluster 0:** Established, moderate-scale categories (36 categories).
- **Cluster 1:** Lower-activity categories (9 categories).
- **Cluster 2:** High-scale categories with the strongest average revenue and order volume (13 categories).
- **Cluster 3:** Smaller-scale categories with the highest average historical growth consistency (12 categories).

The clustering results complement the SQL opportunity classifications, providing an additional perspective on category performance.

## Repository Contents

- `Project_3_Category_Lifecycle_Clustering.ipynb` — Reproducible Python analysis and K-Means clustering.
- `data/` — Category opportunity scores and monthly sales datasets.
- `outputs/` — Cluster assignments, cluster profiles, and supporting visualizations.
- `README.md` — Project documentation.

## Analytical Limitations

The analysis describes historical performance in the available dataset. Growth consistency measures the frequency of revenue increases across eligible consecutive active-month comparisons; it does not predict future growth or demand.

The opportunity classifications are based on defined historical performance thresholds. K-Means identifies patterns in the selected numerical features and does not establish causal relationships.

## Portfolio Case Study

[View the full Project 03 case study](https://drive.google.com/file/d/15poCeUTBt8bbGT_4WWR7oVV9EgGT8Xwb/view?usp=sharing)

## Dataset

Brazilian E-Commerce Public Dataset by Olist, available through Kaggle.
