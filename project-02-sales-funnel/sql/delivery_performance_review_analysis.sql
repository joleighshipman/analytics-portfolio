SELECT
    CASE
        WHEN o.order_delivered_customer_date <=
             o.order_estimated_delivery_date
        THEN 'On-time delivery'
        ELSE 'Late delivery'
    END AS delivery_performance,
    COUNT(DISTINCT r.review_id) AS total_reviews,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    ROUND(
        AVG(
            CASE
                WHEN r.review_score <= 2
                THEN 1.0 ELSE 0.0
            END
        ) * 100,
        2
    ) AS negative_review_pct
FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_performance
ORDER BY delivery_performance;