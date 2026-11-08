WITH customer_order_dates AS (
    SELECT DISTINCT
        c.customer_unique_id,
        o.order_id,
        DATE(o.order_purchase_timestamp) AS purchase_date
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
),
repeat_purchase_intervals AS (
    SELECT
        customer_unique_id,
        purchase_date,
        LAG(purchase_date) OVER (
            PARTITION BY customer_unique_id
            ORDER BY purchase_date
        ) AS previous_purchase_date
    FROM customer_order_dates
)
SELECT
    COUNT(*) AS repeat_purchase_intervals,
    ROUND(
        AVG(
            julianday(purchase_date) -
            julianday(previous_purchase_date)
        ),
        2
    ) AS avg_days_between_purchases,
    ROUND(
        MIN(
            julianday(purchase_date) -
            julianday(previous_purchase_date)
        ),
        2
    ) AS min_days_between_purchases,
    ROUND(
        MAX(
            julianday(purchase_date) -
            julianday(previous_purchase_date)
        ),
        2
    ) AS max_days_between_purchases
FROM repeat_purchase_intervals
WHERE previous_purchase_date IS NOT NULL;