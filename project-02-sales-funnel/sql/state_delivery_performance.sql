SELECT
    c.customer_state,
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(
            julianday(o.order_delivered_customer_date) -
            julianday(o.order_purchase_timestamp)
        ),
        2
    ) AS avg_delivery_days,
    ROUND(
        AVG(
            CASE
                WHEN o.order_delivered_customer_date <=
                     o.order_estimated_delivery_date
                THEN 1.0 ELSE 0.0
            END
        ) * 100,
        2
    ) AS on_time_delivery_pct
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY delivered_orders DESC;