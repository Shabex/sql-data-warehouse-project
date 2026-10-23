
SELECT * FROM bronze.crm_sales_details;

-- CHECKING FOR WHITESPACES
SELECT 
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	FROM bronze.crm_sales_details
	WHERE sls_ord_num != TRIM(sls_ord_num);

-- CHECK IF THERE ARE MISSING sls_prd_key IN THE DIMENSION TABLE silver.crm_prd_info
SELECT 
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	FROM bronze.crm_sales_details
	WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);

-- CHECK IF THERE ARE MISSING sls_cust_id IN THE DIMENSION TABLE silver.crm_cust_info
SELECT 
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	FROM bronze.crm_sales_details
	WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);


-- Checking for Invalid dates
SELECT
NULLIF(sls_order_dt,0) as sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 
	OR len(sls_order_dt) != 8
	OR sls_order_dt > 20500101
	OR sls_order_dt < 19000101;

SELECT
NULLIF(sls_ship_dt,0) as sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
	OR len(sls_ship_dt) != 8
	OR sls_ship_dt > 20500101
	OR sls_ship_dt < 19000101;

SELECT
NULLIF(sls_due_dt,0) as sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
	OR len(sls_due_dt) != 8
	OR sls_due_dt > 20500101
	OR sls_due_dt < 19000101;

-- CHECK FOR invalid date orders
SELECT
		*
	FROM bronze.crm_sales_details
	WHERE sls_order_dt > sls_ship_dt 
	OR sls_order_dt > sls_due_dt
	OR sls_ship_dt > sls_due_dt;

-- Check for Data Consistency: Between Sales, Quantity and Price
-->> Sales = Qty * Price
-->> Values MUST NOT be NULL, zero or negative

SELECT	DISTINCT
		sls_sales 
		sls_quantity,
		sls_price 
	FROM silver.crm_sales_details
	WHERE sls_sales != sls_quantity * sls_price
	OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
	OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
	ORDER BY sls_sales, sls_quantity, sls_price;

SELECT * FROM silver.crm_sales_details;

