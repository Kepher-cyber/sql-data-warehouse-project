-- =============================================================
-- Create Database and Schemas
-- =============================================================
-- Script Purpose:
--     This script creates a new database named 'DataWarehouse'.
--     If the database exists, it is dropped and recreated.
--     Then it sets up three schemas: 'bronze', 'silver', and 'gold'.
--
-- WARNING:
--     Running this script will DROP the entire 'DataWarehouse' database if it exists.
--     All data will be permanently deleted. Use with caution!
-- =============================================================

-- Step 1: Drop the 'DataWarehouse' database if it exists
DO
$$
BEGIN
   IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datawarehouse') THEN
      -- Terminate existing connections
      PERFORM pg_terminate_backend(pid)
      FROM pg_stat_activity
      WHERE datname = 'datawarehouse' AND pid <> pg_backend_pid();

      -- Drop the database
      EXECUTE 'DROP DATABASE datawarehouse';
   END IF;
END
$$;

-- Step 2: Create the 'DataWarehouse' database
CREATE DATABASE datawarehouse;

-- Step 3: Create schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
