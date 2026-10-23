-- Removing '-' from cid column
SELECT 
	cid,
	REPLACE(cid, '-','') AS new_cid
FROM bronze.erp_loc_a101;

-- Standardizing the Countries
SELECT
	DISTINCT cntry,
	CASE
		WHEN UPPER(TRIM(cntry)) IN ('United States','USA', 'US') THEN 'USA'
		WHEN UPPER(TRIM(cntry)) IN ('Germany', 'DE') THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) IS NULL OR UPPER(TRIM(cntry)) = '' THEN 'n/a'
		ELSE (TRIM(cntry))
	END AS new_cntry
--FROM silver.erp_loc_a101;
FROM bronze.erp_cust_az12;