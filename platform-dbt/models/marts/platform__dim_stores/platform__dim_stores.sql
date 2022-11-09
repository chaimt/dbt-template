WITH platform_stg__stores_enrichment AS (

    SELECT * FROM {{ ref('platform_stg__stores_enrichment') }}

), loyalty__dim_merchants AS (

    SELECT * FROM {{ ref('loyalty__dim_merchants') }}

), platform__dim_stores AS (

    SELECT platform_stg__stores_enrichment.store_id,
    platform_stg__stores_enrichment.organization_id,
    platform_stg__stores_enrichment.app_key,
    platform_stg__stores_enrichment.store_domain,
    COALESCE(platform_stg__stores_enrichment.is_test, 0) AS is_test_store,
    COALESCE(platform_stg__stores_enrichment.is_active, 0) AS is_active_store,
    platform_stg__stores_enrichment.store_name,
    platform_stg__stores_enrichment.platform_name,
    loyalty__dim_merchants.merchant_id,
    loyalty__dim_merchants.merchant_created_at,
    loyalty__dim_merchants.company_name AS loyalty_company_name,
    loyalty__dim_merchants.contact_email AS loyalty_contact_email,
    COALESCE(loyalty__dim_merchants.is_test_account, 0) AS loyalty_is_test_account,
    CURRENT_TIMESTAMP AS dwh_updated_at
    FROM platform_stg__stores_enrichment
    LEFT JOIN loyalty__dim_merchants
        ON loyalty__dim_merchants.app_key = platform_stg__stores_enrichment.app_key

)

SELECT * FROM platform__dim_stores
