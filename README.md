# Task 27 – Salesperson Performance Analysis

## Project Overview

This project analyzes person-level sales performance using the Superstore dataset.

The analysis compares performance using four key metrics:

- Sales
- Profit
- Growth
- Average Order Value (AOV)

The objective is to rank individuals based on these metrics and present the results through Excel charts and a dashboard.

## Tools Used

- MySQL
- Microsoft Excel

## Dataset

Dataset: Superstore Sales Dataset

The dataset contains sales transaction information including:

- Order ID
- Order Date
- Customer Name
- Category
- Sales
- Quantity
- Discount
- Profit

## Data Limitation

The available Superstore dataset does not contain a dedicated Salesperson column.

Therefore, Customer_Name was used as a person-level performance proxy for this analysis.

The dashboard and ranking should therefore be interpreted as person-level performance analysis rather than an actual employee salesperson analysis.

## Analysis Performed

The following metrics were calculated:

1. Total Sales
2. Total Profit
3. Sales Growth %
4. Average Order Value (AOV)

Ranking was created for:

- Sales
- Profit
- Growth
- AOV

## SQL Analysis

MySQL was used to calculate yearly sales, profit, growth percentage, AOV and rankings using aggregation and window functions.

Functions used include:

- SUM()
- COUNT()
- LAG()
- RANK()
- YEAR()
- ROUND()
- COALESCE()

## Excel Dashboard

The Excel workbook contains:

### Ranking Sheet

Four charts:

1. Sales Ranking
2. Profit Ranking
3. Growth Ranking
4. AOV Ranking

### Dashboard Sheet

Four KPI cards:

- Total Sales
- Total Profit
- Average Growth %
- Average Order Value

### Recommendations Sheet

Business recommendations based on:

- Sales performance
- Profit performance
- Growth performance
- AOV performance

## Key Findings

- Sales performance differs significantly between individuals.
- Higher sales does not always indicate higher growth.
- Profitability should be considered along with sales.
- AOV helps identify individuals generating higher value per order.
- Positive growth performers can be studied for successful practices.
- Negative growth performers may require further investigation.

## Conclusion

The analysis provides a simple management view of person-level performance using Sales, Profit, Growth and AOV.

The dashboard helps management compare performance and identify areas requiring improvement.
