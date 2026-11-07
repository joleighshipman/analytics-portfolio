WITH months AS (
    SELECT DISTINCT
        strftime('%Y-%m', order_purchase_timestamp) AS month
    FROM orders
),

categories AS (
    SELECT DISTINCT
        product_category_name_english AS category
    FROM product_category_name_translation
    WHERE product_category_name_english IS NOT NULL
),

monthly_sales AS (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS month,
        t.product_category_name_english AS category,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS total_revenue,
        COUNT(oi.order_item_id) AS order_items
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN product_category_name_translation t
        ON p.product_category_name = t.product_category_name
    GROUP BY
        month,
        category
),

complete_monthly_sales AS (
    SELECT
        mc.month,
        mc.category,
        COALESCE(ms.total_orders, 0) AS total_orders,
        COALESCE(ms.total_revenue, 0) AS total_revenue,
        COALESCE(ms.order_items, 0) AS order_items
    FROM (
        SELECT
            m.month,
            c.category
        FROM months m
        CROSS JOIN categories c
    ) mc
    LEFT JOIN monthly_sales ms
        ON mc.month = ms.month
        AND mc.category = ms.category
),

category_growth AS (
    SELECT
        month,
        category,
        total_orders,
        total_revenue,
        order_items,
        LAG(total_revenue) OVER (
            PARTITION BY category
            ORDER BY month
        ) AS previous_month_revenue
    FROM complete_monthly_sales
),

category_metrics AS (
    SELECT
        category,

        ROUND(SUM(total_revenue), 2) AS total_revenue,

        SUM(total_orders) AS total_orders,

        COUNT(
            CASE
                WHEN total_revenue > 0 THEN 1
            END
        ) AS active_months,

        ROUND(
            COUNT(
                CASE
                    WHEN total_revenue > 0 THEN 1
                END
            ) * 100.0 / 25,
            2
        ) AS activity_month_pct,

        ROUND(
            AVG(
                CASE
                    WHEN previous_month_revenue > 0
                         AND total_revenue > 0
                    THEN
                        CASE
                            WHEN total_revenue > previous_month_revenue
                            THEN 1.0
                            ELSE 0.0
                        END
                    ELSE NULL
                END
            ) * 100,
            2
        ) AS growth_consistency_pct

    FROM category_growth
    GROUP BY category
),

scored_categories AS (
    SELECT
        category,
        total_revenue,
        total_orders,
        active_months,
        activity_month_pct,
        growth_consistency_pct,

        (
            CASE
                WHEN total_revenue >= 188825.27
                THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN active_months >= 20
                THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN growth_consistency_pct >= 60
                THEN 1
                ELSE 0
            END
        ) AS opportunity_score

    FROM category_metrics
)

SELECT
    category,
    total_revenue,
    total_orders,
    active_months,
    activity_month_pct,
    growth_consistency_pct,
    opportunity_score,

    CASE
        WHEN opportunity_score = 3
            THEN 'High Opportunity'
        WHEN opportunity_score = 2
            THEN 'Moderate Opportunity'
        WHEN opportunity_score = 1
            THEN 'Limited Opportunity'
        ELSE 'Low Opportunity'
    END AS opportunity_class

FROM scored_categories

ORDER BY
    opportunity_score DESC,
    total_revenue DESC;