WITH delivery_reviews AS (
    SELECT
        r.review_id,
        r.review_score,
        julianday(o.order_delivered_customer_date) -
        julianday(o.order_estimated_delivery_date) AS delay_days
    FROM orders o
    JOIN order_reviews r
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL
)
SELECT
    CASE
        WHEN delay_days <= 0 THEN 'Early or on time'
        WHEN delay_days <= 3 THEN '1-3 days late'
        WHEN delay_days <= 7 THEN '4-7 days late'
        ELSE 'More than 7 days late'
    END AS delivery_delay_group,
    COUNT(DISTINCT review_id) AS total_reviews,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(
        AVG(
            CASE
                WHEN review_score <= 2
                THEN 1.0 ELSE 0.0
            END
        ) * 100,
        2
    ) AS negative_review_pct
FROM delivery_reviews
GROUP BY delivery_delay_group
ORDER BY
    CASE delivery_delay_group
        WHEN 'Early or on time' THEN 1
        WHEN '1-3 days late' THEN 2
        WHEN '4-7 days late' THEN 3
        ELSE 4
    END;