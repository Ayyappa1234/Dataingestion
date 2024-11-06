IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'MyDelimitedTextFormat') 
    CREATE EXTERNAL FILE FORMAT [MyDelimitedTextFormat] 
    WITH ( 
        FORMAT_TYPE = DELIMITEDTEXT,
        FORMAT_OPTIONS (
            FIELD_TERMINATOR = ',',
            STRING_DELIMITER = '"',
            FIRST_ROW = 2,
            USE_TYPE_DEFAULT = FALSE
        )
    );
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'MyDataLakeStorage') 
CREATE EXTERNAL DATA SOURCE [MyDataLakeStorage]
WITH (
    LOCATION = 'abfss://accounts@301238302.dfs.core.windows.net'
);

CREATE EXTERNAL TABLE dbo.accounts (
    account_id INT,
    customer_id INT,
    account_type NVARCHAR(50),
    balance FLOAT
)
WITH (
    LOCATION = 'accounts.csv',  
    DATA_SOURCE = [MyDataLakeStorage],
    FILE_FORMAT = [MyDelimitedTextFormat]
);

SELECT TOP 100 * FROM dbo.accounts;


