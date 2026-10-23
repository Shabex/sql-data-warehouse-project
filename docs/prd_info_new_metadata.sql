 
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
 CREATE TABLE silver.crm_prd_info (
    prd_id       INT,
	cat_id		 NVARCHAR(50),
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);

SELECT
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5), '-','_') AS cat_id,
	SUBSTRING(prd_key,7, LEN(prd_key))AS prd_key,
	prd_nm,
	ISNULL(prd_cost,0) AS prd_cost,
	CASE UPPER(TRIM(prd_line))
		WHEN 'M' THEN 'Mountain' 
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales' 
		WHEN 'T' THEN 'Touring'
		ELSE 'n/a'
	END prd_line,
	CAST(prd_start_dt AS DATE) AS prd_start_dt,
	CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;

--SELECT * FROM bronze.crm_sales_details;
