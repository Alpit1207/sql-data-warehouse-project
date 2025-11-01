/*
=========================================================================================
stored procedures : Load Bronze layer(source -> Bronze)
=========================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external csv files.
  It performs the following actions:
  - truncates the tables before loading
  - use the 'bulk insert' command to load the data into tables.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @main_start_time DATETIME , @main_end_time DATETIME;
	BEGIN TRY
		SET @main_start_time = GETDATE();
		PRINT '===================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===================================================';


		PRINT '===================================================';
		PRINT 'Loading CRM Tables';
		PRINT '===================================================';

		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting Data into :bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';

		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting Data into :bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';

		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserting Data into :bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';

		PRINT '===================================================';
		PRINT 'Loading ERP Tables';
		PRINT '===================================================';
		
		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
	
		PRINT 'Inserting Data into :bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';
		
		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;
	
		PRINT 'Inserting Data into :bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';

		SET @start_time = GETDATE();
		PRINT 'Truncating table :bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
	
		PRINT 'Inserting Data into :bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'D:\Data engineering 2025\sql 2025 BARAA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + cast(Datediff(second,@start_time,@end_time) as nvarchar)+ 'seconds';
		PRINT '>> ===================================================';

		SET @main_end_time = GETDATE();
		PRINT '>> BRONZE LOAD DURATION: ' + CAST(DATEDIFF(SECOND,@main_start_time,@main_end_time) as nvarchar) + 'seconds';

	END TRY
	BEGIN CATCH 
		PRINT '===================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================================';
	END CATCH
END

