
EXEC sp_help 'bronze.erp_cust_az12';

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'bronze'
  AND TABLE_NAME = 'erp_cust_az12'
  AND COLUMN_NAME = 'bdate';


SELECT
	cid,
	bdate,
	gen
	--FROM bronze.erp_cust_az12;
	FROM silver.erp_cust_az12;


SELECT
	CASE
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
		ELSE cid
	END cid,
	bdate,
	gen
	FROM bronze.erp_cust_az12;

	-- IDENTIFY OUT OF RANGE DATES
	SELECT 
			DISTINCT bdate
		FROM bronze.erp_cust_az12
		WHERE bdate < '1924-01-01' OR bdate > GETDATE();

	-- Data Standardization and Consistency
	SELECT
			DISTINCT gen
		--FROM bronze.erp_cust_az12;
		FROM silver.erp_cust_az12;


