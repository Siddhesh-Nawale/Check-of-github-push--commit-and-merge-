---added the joker part!!!!!!!!!!
WITH basedata as (
    SELECT
        distinct obt.COMPANY_ID,
        obt.REPORTING_DATE,
        IFF(
            PRODUCT_CATEGORIZATION_PRODUCT_PLAN in ('-', 'Basic', 'Standard', 'Premium')
            and PRODUCT_CATEGORIZATION_LICENSE_SERVICE_TYPE in (
          a      'SaaS',
                'Maintenance',
                'On Premise (Subscription)'
            ),
            UNITS,
            0
        ) AS UNITS,
        MRR AS MRR
    FROM
        ANALYTICS.DBO.GROWTH__OBT obt
    WHERE
        METRIC_OBJECT = 'applied_billings'
        AND PRODUCT_CATEGORIZATION_PRODUCT_LINE = 'Manage'
        AND PRODUCT_CATEGORIZATION_PRODUCT_PACKAGE = 'Manage'
        AND PRODUCT_CATEGORIZATION_LICENSE_SERVICE_TYPE in (
            'SaaS',
            'Maintenance',
            'On Premise (Subscription)'
        )
        AND MRR <> 0
)
