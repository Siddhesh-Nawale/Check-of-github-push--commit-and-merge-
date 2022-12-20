--- added THE plan part !!!!!!!!!!!!!!! WITH basedata AS (
    SELECT
        DISTINCT obt.company_id,
        obt.reporting_date,
        IFF(
            product_categorization_product_plan IN (
                '-',
                'Basic',
                'Standard',
                'Premium'
            )
            AND product_categorization_license_service_type IN (
                A 'SaaS',
                'Maintenance',
                'On Premise (Subscription)'
            ),
            units,
            0
        ) AS units,
        mrr AS mrr
    FROM
        analytics.dbo.growth__obt obt
    WHERE
        metric_object = 'applied_billings'
        AND product_categorization_product_line = 'Manage'
        AND product_categorization_product_package = 'Manage'
        AND product_categorization_license_service_type IN (
            'SaaS',
            'Maintenance',
            'On Premise (Subscription)'
        )
        AND mrr <> 0
)
