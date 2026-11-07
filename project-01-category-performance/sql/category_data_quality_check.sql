SELECT
    COUNT(*) AS uncategorized_items,
    ROUND(SUM(oi.price), 2) AS uncategorized_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND (
      p.product_category_name IS NULL
      OR TRIM(p.product_category_name) = ''
  );
