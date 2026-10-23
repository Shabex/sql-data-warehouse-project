SELECT 
		id,
		cat,
		subcat,
		maintenance
	FROM bronze.erp_px_cat_g1v2;

-- SELECT * FROM silver.crm_prd_info;

-- Check for Unwanted Spaces
SELECT *
	FROM bronze.erp_px_cat_g1v2
	WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Check for data Standardization
SELECT 
		DISTINCT maintenance
	FROM bronze.erp_px_cat_g1v2;