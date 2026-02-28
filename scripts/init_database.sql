/*
Purpose:
This script creates a new database 'DataWarehouse' after checking its existence.
If the database exists, it DROP and RECREATES the 'DataWarehouse' database.
Then creates 3 schemas named: bronze, silver, gold.

WARNING:
The script drops the 'DataWarehouse' database including whole datas inside.
So make sure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the Database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END
GO

-- Creating The Database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
