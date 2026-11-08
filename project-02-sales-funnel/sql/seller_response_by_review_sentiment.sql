SELECT
    CASE
        WHEN review_score <= 2 THEN 'Negative review'
        WHEN review_score = 3 THEN 'Neutral review'
        ELSE 'Positive review'
    END AS review_category,
    COUNT(*) AS total_reviews,
    ROUND(
        AVG(
            julianday(review_answer_timestamp) -
            julianday(review_creation_date)
        ),
        2
    ) AS avg_response_days,
    ROUND(
        AVG(
            CASE
                WHEN julianday(review_answer_timestamp) -
                     julianday(review_creation_date) <= 1
                THEN 1.0 ELSE 0.0
            END
        ) * 100,
        2
    ) AS response_within_one_day_pct
FROM order_reviews
WHERE review_answer_timestamp IS NOT NULL
GROUP BY review_category
ORDER BY
    CASE review_category
        WHEN 'Negative review' THEN 1
        WHEN 'Neutral review' THEN 2
        ELSE 3
    END;