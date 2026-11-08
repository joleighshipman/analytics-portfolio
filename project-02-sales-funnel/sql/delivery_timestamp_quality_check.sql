SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
FROM orders
WHERE
    (order_status = 'delivered'
     AND order_delivered_customer_date IS NULL)
    OR
    (order_status = 'canceled'
     AND order_delivered_customer_date IS NOT NULL)
ORDER BY order_status, order_purchase_timestamp;
