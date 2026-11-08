SELECT
    CASE
        WHEN julianday(review_answer_timestamp) -
             julianday(review_creation_date) <= 1
            THEN 'Within 1 day'
        WHEN julianday(review_answer_timestamp) -
             julianday(review_creation_date) <= 3
            THEN '2-3 days'
        WHEN julianday(review_answer_timestamp) -
             julianday(review_creation_date) <= 7
            THEN '4-7 days'
        ELSE 'More than 7 days'
    END AS response_time_group,
    COUNT(*) AS total_reviews,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM order_reviews),
        2
    ) AS review_percentage
FROM order_reviews
WHERE review_answer_timestamp IS NOT NULL
GROUP BY response_time_group
ORDER BY
    CASE response_time_group
        WHEN 'Within 1 day' THEN 1
        WHEN '2-3 days' THEN 2
        WHEN '4-7 days' THEN 3
        ELSE 4
    END;