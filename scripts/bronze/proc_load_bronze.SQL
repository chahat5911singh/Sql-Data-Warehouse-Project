use DataWarehouse;

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);


CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);


CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);



-- loading  all data into the tables      &         using stored procedure


create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime , @end_time datetime
begin try
print '=========================================================================';
print 'Loading bronze Layer ';
print '=========================================================================';

print '-------------------------------------------------------------------------';
print 'Loading CRM tables';
print '-------------------------------------------------------------------------';

set @start_time = getdate();
truncate table bronze.crm_cust_info;

bulk insert bronze.crm_cust_info
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
    firstrow  = 2,                            -- used to tell where the first row is start
    fieldterminator = ',' ,                   -- used to tell the machine ',' is used to seperate the colm & row
    tablock                                   --  for lock the table
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'


set @start_time = getdate();
truncate table bronze.crm_prd_info;
bulk insert bronze.crm_cust_info
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
    firstrow  = 2,                           
    fieldterminator = ',' ,                   
    tablock                                  
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'


set @start_time = getdate();
truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
    firstrow  = 2,                           
    fieldterminator = ',' ,                   
    tablock                                  
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'

print '-------------------------------------------------------------------------';
print 'Loading ERP tables';
print '-------------------------------------------------------------------------';

set @start_time = getdate();
truncate table bronze.erp_loc_a101;
bulk insert bronze.erp_loc_a101
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with(
    firstrow  = 2,                           
    fieldterminator = ',' ,                   
    tablock                                  
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'

set @start_time = getdate();
truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with(
    firstrow  = 2,                           
    fieldterminator = ',' ,                   
    tablock                                  
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'

set @start_time = getdate();
truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\Chahat Singh\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with(
    firstrow  = 2,                           
    fieldterminator = ',' ,                   
    tablock                                  
);
set @end_time = getdate();
print 'Load duration:'+ cast (datediff(second,@start_time,@end_time) as nvarchar) + 'seconds';
print '---------------------------------------------------'
end try
begin catch
print '====================================================================';
print ' ERROR occur in loading the bronze layer';
print'=====================================================================';
end catch
end

