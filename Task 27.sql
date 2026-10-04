
INSERT INTO superstore
(Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name,
Segment, Country, City, State_Province, Postal_Code, Region, Product_ID,
Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit)
VALUES

(1, 'ORD001', '2022-01-10', '2022-01-13', 'First Class', 'C001', 'Arun',
'Consumer', 'United States', 'New York', 'New York', '10001', 'East',
'P001', 'Technology', 'Phones', 'Phone A', 1200.00, 3, 0.00, 240.00),

(2, 'ORD002', '2022-02-15', '2022-02-18', 'Second Class', 'C002', 'Bala',
'Corporate', 'United States', 'Chicago', 'Illinois', '60001', 'Central',
'P002', 'Technology', 'Computers', 'Computer A', 1800.00, 2, 0.00, 360.00),

(3, 'ORD003', '2022-03-20', '2022-03-23', 'Standard Class', 'C003', 'Karthik',
'Consumer', 'United States', 'Dallas', 'Texas', '75001', 'Central',
'P003', 'Furniture', 'Chairs', 'Chair A', 750.00, 5, 0.10, 120.00),

(4, 'ORD004', '2022-04-12', '2022-04-15', 'First Class', 'C004', 'David',
'Corporate', 'United States', 'Seattle', 'Washington', '98001', 'West',
'P004', 'Office Supplies', 'Binders', 'Binder A', 450.00, 10, 0.00, 90.00),

(5, 'ORD005', '2022-05-18', '2022-05-21', 'Second Class', 'C005', 'Manoj',
'Consumer', 'United States', 'Boston', 'Massachusetts', '02101', 'East',
'P005', 'Technology', 'Accessories', 'Accessory A', 950.00, 4, 0.00, 190.00),

(6, 'ORD006', '2022-06-25', '2022-06-28', 'Standard Class', 'C006', 'Arun',
'Consumer', 'United States', 'New York', 'New York', '10002', 'East',
'P006', 'Technology', 'Phones', 'Phone B', 1500.00, 3, 0.00, 300.00),

(7, 'ORD007', '2022-07-10', '2022-07-13', 'First Class', 'C007', 'Bala',
'Corporate', 'United States', 'Chicago', 'Illinois', '60002', 'Central',
'P007', 'Furniture', 'Tables', 'Table A', 2200.00, 2, 0.10, 330.00),

(8, 'ORD008', '2022-08-14', '2022-08-17', 'Second Class', 'C008', 'Karthik',
'Consumer', 'United States', 'Dallas', 'Texas', '75002', 'Central',
'P008', 'Technology', 'Computers', 'Computer B', 2000.00, 2, 0.00, 400.00),

(9, 'ORD009', '2022-09-22', '2022-09-25', 'Standard Class', 'C009', 'David',
'Corporate', 'United States', 'Seattle', 'Washington', '98002', 'West',
'P009', 'Office Supplies', 'Storage', 'Storage A', 600.00, 8, 0.00, 120.00),

(10, 'ORD010', '2022-10-05', '2022-10-08', 'First Class', 'C010', 'Manoj',
'Consumer', 'United States', 'Boston', 'Massachusetts', '02102', 'East',
'P010', 'Technology', 'Accessories', 'Accessory B', 1100.00, 5, 0.00, 220.00),

(11, 'ORD011', '2023-01-12', '2023-01-15', 'First Class', 'C001', 'Arun',
'Consumer', 'United States', 'New York', 'New York', '10001', 'East',
'P011', 'Technology', 'Phones', 'Phone C', 1800.00, 4, 0.00, 360.00),

(12, 'ORD012', '2023-02-18', '2023-02-21', 'Second Class', 'C002', 'Bala',
'Corporate', 'United States', 'Chicago', 'Illinois', '60001', 'Central',
'P012', 'Technology', 'Computers', 'Computer C', 2500.00, 3, 0.00, 500.00),

(13, 'ORD013', '2023-03-15', '2023-03-18', 'Standard Class', 'C003', 'Karthik',
'Consumer', 'United States', 'Dallas', 'Texas', '75001', 'Central',
'P013', 'Furniture', 'Chairs', 'Chair B', 900.00, 6, 0.10, 150.00),

(14, 'ORD014', '2023-04-20', '2023-04-23', 'First Class', 'C004', 'David',
'Corporate', 'United States', 'Seattle', 'Washington', '98001', 'West',
'P014', 'Office Supplies', 'Binders', 'Binder B', 700.00, 12, 0.00, 140.00),

(15, 'ORD015', '2023-05-25', '2023-05-28', 'Second Class', 'C005', 'Manoj',
'Consumer', 'United States', 'Boston', 'Massachusetts', '02101', 'East',
'P015', 'Technology', 'Accessories', 'Accessory C', 1400.00, 6, 0.00, 280.00);

SELECT COUNT(*) AS Total_Rows
FROM superstore;

SELECT *
FROM superstore;

-- 1. YEARLY SALES AND PROFIT
WITH yearly_data AS (
    SELECT
        Customer_Name,
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales) AS Sales,
        SUM(Profit) AS Profit,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        SUM(Sales) / COUNT(DISTINCT Order_ID) AS AOV
    FROM superstore
    GROUP BY Customer_Name, YEAR(Order_Date)
),

-- 2. CALCULATE PREVIOUS YEAR SALES
growth_data AS (
    SELECT
        Customer_Name,
        Sales_Year,
        Sales,
        Profit,
        Total_Orders,
        AOV,
        LAG(Sales) OVER (
            PARTITION BY Customer_Name
            ORDER BY Sales_Year
        ) AS Previous_Year_Sales
    FROM yearly_data
),

-- 3. CALCULATE GROWTH %
final_data AS (
    SELECT
        Customer_Name,
        Sales_Year,
        Sales,
        Profit,
        AOV,
        Previous_Year_Sales,
        CASE
            WHEN Previous_Year_Sales IS NULL
                 OR Previous_Year_Sales = 0
            THEN NULL
            ELSE
                ((Sales - Previous_Year_Sales)
                / Previous_Year_Sales) * 100
        END AS Growth_Percentage
    FROM growth_data
)

-- 4. FINAL RANKING
SELECT
    Customer_Name,
    Sales_Year,
    ROUND(Sales, 2) AS Sales,
    ROUND(Profit, 2) AS Profit,
    ROUND(Growth_Percentage, 2) AS Growth_Percentage,
    ROUND(AOV, 2) AS Average_Order_Value,

    RANK() OVER (
        PARTITION BY Sales_Year
        ORDER BY Sales DESC
    ) AS Sales_Rank,

    RANK() OVER (
        PARTITION BY Sales_Year
        ORDER BY Profit DESC
    ) AS Profit_Rank,

    RANK() OVER (
        PARTITION BY Sales_Year
        ORDER BY Growth_Percentage DESC
    ) AS Growth_Rank,

    RANK() OVER (
        PARTITION BY Sales_Year
        ORDER BY AOV DESC
    ) AS AOV_Rank

FROM final_data
ORDER BY Sales_Year, Sales_Rank;