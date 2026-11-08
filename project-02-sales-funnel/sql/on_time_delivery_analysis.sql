SELECT
    COUNT(*) AS delivered_orders,
    SUM(
        CASE
            WHEN order_delivered_customer_date <=
                 order_estimated_delivery_date
            THEN 1 ELSE 0
        END
    ) AS delivered_on_time,
    SUM(
        CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1 ELSE 0
        END
    ) AS delivered_late,
    ROUND(
        AVG(
            CASE
                WHEN order_delivered_customer_date <=
                     order_estimated_delivery_date
                THEN 1.0 ELSE 0.0
            END
        ) * 100,
        2
    ) AS on_time_delivery_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;