/*
Purpose:
This script generates a stored procedure named 'bronze.load_bronze' which truncates the tables and reloads them in order to keep database up to date.
Also gives extra informations in case of errors and shows the process time for each table.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @whole_start_time DATETIME, @whole_end_time DATETIME
	BEGIN TRY
	SET @whole_start_time = GETDATE()
		PRINT '########################################';
		PRINT 'Loading Bronze Layer';
		PRINT '########################################';

		PRINT '----------------------------------------';
		PRINT 'Loading CRM Table: bronze.crm_cust_info';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.crm_cust_info

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '----------------------------------------';
		PRINT 'Loading CRM Table: bronze.crm_sales_details';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.crm_sales_details

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '----------------------------------------';
		PRINT 'Loading CRM Table: bronze.crm_prd_info';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.crm_prd_info

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '----------------------------------------';
		PRINT 'Loading ERP Table: bronze.erp_CUST_AZ12';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.erp_CUST_AZ12

		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '----------------------------------------';
		PRINT 'Loading ERP Table: bronze.erp_LOC_A101';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.erp_LOC_A101

		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		PRINT '----------------------------------------';
		PRINT 'Loading ERP Table: bronze.erp_PX_CAT_G1V2';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2

		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\Gaming\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2
			,FIELDTERMINATOR = ','
			,TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '----------------------------------------';
	PRINT 'Loading Process Completed.'
	SET @whole_end_time = GETDATE()
	PRINT 'Whole Process Duration: ' + CAST(DATEDIFF(SECOND, @whole_start_time, @whole_end_time) AS NVARCHAR) + ' seconds'
	END TRY
	BEGIN CATCH
		PRINT '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
		PRINT 'An Error Occured While Loading Bronze Layer'
		PRINT 'Error Message:' + ERROR_MESSAGE()
		PRINT 'Error Number:' + CAST(ERROR_NUMBER() AS NVARCHAR)
	END CATCH
END
