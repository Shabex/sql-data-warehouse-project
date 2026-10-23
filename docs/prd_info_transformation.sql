PRINT '>> Truncating Table: silver.crm_prd_info';
TRUNCATE TABLE silver.crm_prd_info;
PRINT '>> Inserting Data into: silver.crm_prd_info';

INSERT INTO silver.crm_prd_info (
	prd_id,
	cat_id,
    prd_key,      
    prd_nm,       
    prd_cost,
    prd_line,     
    prd_start_dt,
    prd_end_dt
)

SELECT
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5), '-','_') AS cat_id, -- Extract category ID
	SUBSTRING(prd_key,7, LEN(prd_key))AS prd_key, -- Extract Product Key
	prd_nm,
	ISNULL(prd_cost,0) AS prd_cost, -- Handling Null Replacing Null by zero 
	CASE UPPER(TRIM(prd_line))
		WHEN 'M' THEN 'Mountain' 
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales' 
		WHEN 'T' THEN 'Touring'
		ELSE 'n/a'
	END prd_line,
	CAST(prd_start_dt AS DATE) AS prd_start_dt, -- Type casting data to date
	CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt -- Data Typecasting and Enrichment by calculating end date as one day before the next start date
FROM bronze.crm_prd_info;