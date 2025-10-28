-- Create Database
CREATE DATABASE CDC_Test;
GO
USE CDC_Test;
GO

-- Create Table
CREATE TABLE dbo.ForexRates (
    RateID INT IDENTITY(1,1) PRIMARY KEY,
    BaseCurrency VARCHAR(10),
    Timestamp DATETIME2 DEFAULT SYSDATETIME(),
    INR DECIMAL(18,6),
    EUR DECIMAL(18,6),
    GBP DECIMAL(18,6),
    JPY DECIMAL(18,6),
    AUD DECIMAL(18,6)
);
GO

-- Enable CDC at Database level
ALTER DATABASE CDC_Test SET RECOVERY FULL;
GO
EXEC sys.sp_cdc_enable_db;
GO

-- Enable CDC at Table level
EXEC sys.sp_cdc_enable_table
    @source_schema = N'dbo',
    @source_name   = N'ForexRates',
    @role_name     = NULL,
    @supports_net_changes = 1;
GO

-- Enable advanced options
EXEC sp_configure 'show advanced options', 1;
GO

-- Enable CLR
EXEC sp_configure 'clr enabled', 1;
GO

-- Verify CDC enabled at DB level
SELECT is_cdc_enabled FROM sys.databases WHERE name = 'CDC_Test';

-- Verify CDC enabled at table level
SELECT name, is_tracked_by_cdc FROM sys.tables;


