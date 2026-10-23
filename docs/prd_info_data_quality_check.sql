
SELECT * FROM silver.crm_prd_info;


-- Check for duplicates or Nulls in Primary key
-- Expectations: No Results
TRUNCATE TABLE silver.crm_prd_info;
SELECT
		prd_id,
		count(*)
	FROM silver.crm_prd_info
	GROUP BY prd_id
	HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- Expectations: No Results

SELECT
		prd_nm
	FROM silver.crm_prd_info
	--FROM bronze.crm_prd_info
	WHERE prd_nm != TRIM(prd_nm);

-- Check for nulls and negative numbers
-- Expectations: No Results
SELECT 
		prd_cost
	--FROM bronze.crm_prd_info
	FROM silver.crm_prd_info
	WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line 
FROM silver.crm_prd_info
--FROM bronze.crm_prd_info;

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;



