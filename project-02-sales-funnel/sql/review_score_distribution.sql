SELECT
    review_score,
    COUNT(DISTINCT review_id) AS total_reviews,
    ROUND(
        COUNT(DISTINCT review_id) * 100.0 /
        (SELECT COUNT(DISTINCT review_id)
         FROM order_reviews),
        2
    ) AS review_percentage
FROM order_reviews
GROUP BY review_score
ORDER BY review_score;