PRINT '>> Trancating Table: silver.erp_loc_a101';
TRUNCATE TABLE silver.erp_loc_a101;
PRINT '>> Inserting Data Into: silver.erp_loc_a101';
INSERT INTO silver.erp_loc_a101(
cid,
cntry
)
SELECT 
REPLACE(cid, '-','') AS cid,
CASE
		WHEN UPPER(TRIM(cntry)) IN ('United States','USA', 'US') THEN 'USA'
		WHEN UPPER(TRIM(cntry)) IN ('Germany', 'DE') THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) IS NULL OR UPPER(TRIM(cntry)) = '' THEN 'n/a'
		ELSE (TRIM(cntry))
	END AS cntry
FROM bronze.erp_loc_a101;

