WITH months AS (
    SELECT DISTINCT
        strftime('%Y-%m', order_purchase_timestamp) AS month
    FROM orders
),

categories AS (
    SELECT DISTINCT
        product_category_name_english AS category
    FROM product_category_name_translation
    WHERE product_category_name_english IS NOT NULL
),

monthly_sales AS (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS month,
        t.product_category_name_english AS category,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS total_revenue,
        COUNT(oi.order_item_id) AS units_sold
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    GROUP BY month, category
)

SELECT
    month,
    category,
    total_orders,
    total_revenue,
    units_sold
FROM monthly_sales
ORDER BY category, month;