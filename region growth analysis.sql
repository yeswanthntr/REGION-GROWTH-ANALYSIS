use superstore_db;
select * from store;
SELECT
    Region,
    YEAR(`Order Date`) AS Sales_Year,
    SUM(Sales) AS Total_Sales
FROM store
GROUP BY
    Region,
    YEAR(`Order Date`)
ORDER BY
    Region,
    Sales_Year;
SELECT
    Region,
    YEAR(`Order Date`) AS Year,
    SUM(Sales) AS Sales,
    SUM(Sales) - LAG(SUM(Sales)) OVER(
        PARTITION BY Region
        ORDER BY YEAR(`Order Date`)
    ) AS Sales_Growth
FROM store
GROUP BY Region, YEAR(`Order Date`)
ORDER BY Region, Year;


SELECT
    Region,
    Year,
    Sales,
    ROUND(
        (Sales - LAG(Sales) OVER (
            PARTITION BY Region ORDER BY Year
        ))
        / LAG(Sales) OVER (
            PARTITION BY Region ORDER BY Year
        ) * 100,
        2
    ) AS Growth_Percent
FROM (
    SELECT
        Region,
        YEAR(`Order Date`) AS Year,
        SUM(Sales) AS Sales
    FROM store
    GROUP BY Region, YEAR(`Order Date`)
) AS x
ORDER BY Region, Year;