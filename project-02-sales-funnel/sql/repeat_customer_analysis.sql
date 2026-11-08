WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_orders),
        2
    ) AS customer_percentage
FROM customer_orders
GROUP BY customer_type
ORDER BY total_customers DESC;