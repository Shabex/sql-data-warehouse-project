CREATE VIEW gold.dim_products AS
SELECT 
		ROW_NUMBER()OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
		pn.prd_id AS product_id ,
		pn.prd_key AS product_number,
		pn.prd_nm AS product_name,
		pn.prd_line AS product_line,
		pn.cat_id AS category_id,
		px.cat AS category,
		px.subcat AS subcategory,
		px.maintenance,
		pn.prd_cost AS cost,
		pn.prd_start_dt AS start_date
	FROM silver.crm_prd_info pn
		LEFT JOIN silver.erp_px_cat_g1v2 px
			ON pn.cat_id = px.id
	WHERE pn.prd_end_dt IS NULL; -- Filter out historical data, only use current data where end_date IS NULL

--SELECT * FROM silver.erp_px_cat_g1v2;