WITH order_payment_types AS (
    SELECT DISTINCT
        order_id,
        payment_type
    FROM order_payments
),
payment_reviews AS (
    SELECT
        p.payment_type,
        r.review_id,
        r.review_score
    FROM order_payment_types p
    JOIN order_reviews r
        ON p.order_id = r.order_id
)
SELECT
    payment_type,
    COUNT(DISTINCT review_id) AS total_reviews,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    ROUND(
        AVG(
            CASE
                WHEN review_score <= 2 THEN 1.0
                ELSE 0.0
            END
        ) * 100,
        2
    ) AS negative_review_pct
FROM payment_reviews
GROUP BY payment_type
ORDER BY total_reviews DESC;