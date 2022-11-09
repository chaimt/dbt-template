/*
in production table name will be without [domain]_stg__
*/
WITH source AS (

    SELECT * FROM {{ source('platform__abc', 'accounts') }}

), platform_stg__accounts AS (

    SELECT 
		id,
		app_key,
		domain,
		referal,
		active AS is_active,
		account_type_id,
		created_at,
		updated_at,
		name,
		url,
		category_id,
		organization_id,
		is_test
    FROM source 

)

SELECT * 
FROM platform_stg__accounts
