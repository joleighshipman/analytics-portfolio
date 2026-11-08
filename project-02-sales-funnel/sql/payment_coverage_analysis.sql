SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT op.order_id) AS orders_with_payments,
    ROUND(
        COUNT(DISTINCT op.order_id) * 100.0 /
        COUNT(DISTINCT o.order_id),
        4
    ) AS payment_coverage_pct,
    ROUND(SUM(op.payment_value), 2) AS total_payment_value
FROM orders o
LEFT JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY o.order_status
ORDER BY total_orders DESC;