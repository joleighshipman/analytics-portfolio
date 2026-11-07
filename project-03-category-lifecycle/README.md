# Project 03: Category Lifecycle & Opportunity Analysis

## Project Overview

This project examines historical product category performance using the Brazilian Olist e-commerce dataset, covering September 2016 through October 2018.

The analysis combines SQL-based performance measurement, Python feature engineering and K-Means clustering, and Power BI visualizations to evaluate category scale, activity, historical growth consistency, and commercial opportunity.

The objective is to translate transactional data into actionable business insights about category performance and potential areas of commercial opportunity.

## Business Objective

Identify distinct product category performance patterns and evaluate how established, lower-activity, and higher-growth-consistency categories differ across key commercial metrics.

The analysis uses two complementary approaches: rule-based SQL opportunity scoring and unsupervised machine learning to identify category performance segments.

## Tools & Technologies

- SQL
- Python
- Pandas and NumPy
- Scikit-learn
- Matplotlib and Seaborn
- Power BI

## Analytical Approach

### 1. SQL Performance Analysis

- Aggregated monthly category revenue, order volume, and units sold across the 25-month observation period.
- Evaluated category activity and revenue performance.
- Calculated historical growth consistency using eligible consecutive active-month revenue comparisons.
- Developed a rule-based opportunity scoring framework using three performance indicators:
  - Total revenue
  - Number of active months
  - Historical growth consistency
- Assigned opportunity classifications based on cumulative scores ranging from zero to three.

### 2. Python Clustering Analysis

Prepared five numerical category performance features:

- Total revenue
- Total orders
- Active months
- Activity month percentage
- Growth consistency percentage

StandardScaler was used to standardize the features before applying K-Means clustering.

The analysis evaluated cluster configurations from two through ten clusters. A four-cluster solution was selected because it achieved the highest silhouette score among the tested configurations (0.453).

The clustering analysis included 70 categories with complete values across all five features.

### 3. Power BI Visualization

Developed dashboards to communicate category performance, lifecycle patterns, and commercial opportunity.

The visualizations provide a business-facing view of historical performance and support comparisons across product categories.

## Key Findings

The four-cluster solution identified distinct category performance patterns:

- **Cluster 0: Established, Moderate-Scale Categories (36)**  
  A broad group of categories with relatively consistent activity and moderate average revenue and order volume.

- **Cluster 1: Lower-Activity Categories (9)**  
  Categories with the lowest average revenue, order volume, and activity. Eight of the nine categories also received a Low Opportunity classification.

- **Cluster 2: High-Scale Categories (13)**  
  The strongest commercial-scale segment, with the highest average revenue and order volume. All 13 categories received either a High or Moderate Opportunity classification.

- **Cluster 3: Smaller-Scale, Higher-Growth-Consistency Categories (12)**  
  Categories with comparatively lower revenue and order volume but the highest average historical growth consistency at 67.05%.

### Opportunity Scoring and Clustering Comparison

The SQL opportunity scoring framework and K-Means clustering identified complementary performance patterns.

Cluster 2 contained all 13 categories classified as High or Moderate Opportunity, while Cluster 1 contained eight of the nine Low Opportunity categories.

This comparison demonstrates how rule-based performance thresholds and unsupervised machine learning can provide different but complementary perspectives on category performance.

## Repository Contents

- `Project_3_Category_Lifecycle_Clustering.ipynb` — Reproducible Python analysis and K-Means clustering.
- `data/` — Category opportunity scores and monthly sales datasets.
- `outputs/` — Cluster assignments, cluster profiles, and supporting visualizations.
- `README.md` — Project documentation.
- `sql/` — SQL scripts for monthly sales aggregation and category opportunity scoring.

## Analytical Limitations

This analysis describes historical performance within the available dataset and does not predict future revenue, demand, or category success.

Growth consistency measures the percentage of eligible consecutive calendar-month comparisons in which revenue increased. Comparisons are excluded when either month's revenue is zero. Categories without sufficient eligible comparisons retain an undefined growth consistency value and are excluded from clustering.

Revenue represents product item prices and excludes freight charges. Category-level distinct order counts may overlap because a single order can contain products from multiple categories.

The opportunity classifications are based on defined historical performance thresholds rather than predictive modeling.

K-Means identifies patterns in the selected numerical features and does not establish causal relationships. The four-cluster solution achieved the highest silhouette score among the configurations tested, although the scores for two and three clusters were relatively close. Revenue and order distributions are also right-skewed, which is a consideration when interpreting the standardized clustering results.

## Portfolio Case Study

[View the full Project 03 case study](https://drive.google.com/file/d/15poCeUTBt8bbGT_4WWR7oVV9EgGT8Xwb/view?usp=sharing)

## Dataset

Brazilian E-Commerce Public Dataset by Olist, available through Kaggle.
