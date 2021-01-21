--use [DW DataMart 2015];

--truncate table [etl].[lu_master_product];

--insert into [ETL].[LU_Master_Product] (MProductGroup, MProduct_Code, MProduct_desc, MProduct_ImageURL, Brand_Key, Category_KEY, DWH_Create_date, DWH_Update_Date)
select 
 XXXX.ProductGroup MProductGroup
,XXXX.Product_Code MProduct_Code
,MAX(XXXX.Product_Desc) MProduct_Desc
,MAX(XXXX.Product_ImageURL) MProduct_ImageURL
,MAX(BRAND_KEY) Brand_Key
,MAX(CATEGORY_KEY) Category_KEY
,max([SUPPLIER_KEY]) Supplier_KEY
,max(DWH_Create_Date) DWH_Create_Date 
,max(DWH_Update_Date) DWH_Update_Date
 from (
SELECT 
'NSO' SourceTable
-- [NSO_Product_KEY]
[Department] ProductGroup, 
[ProductCode] Product_Code, 
[Description] Product_Desc, 
[BRAND_KEY], 
[CATEGORY_KEY], 
[SUPPLIER_KEY], 
[ImageName] Product_ImageURL,
[Import_DateTime] DWH_Create_Date, 
[Import_DateTime] DWH_Update_Date
--,Brand
FROM [DW DataMart 2015].[DWH].[LU_National_Product]
where 1=1
--and ProductGroup like 'POST%'
--and ProductCode in ( '5500021','chr14','o5500021')
--  and ProductCode = '5500021'
--  and Description like '%GREEN%BLACK%'
--  and BRAND is not null

union

SELECT 
'P' SourceTable
-- [NSO_Product_KEY]
,[ProductGroup]
,[Product_Code]
,[Product_Desc]
,[Brand_Key]
,[CATEGORY_KEY]
,[SUPPLIER_KEY]
,[Product_ImageURL]
,[DWH_Create_Date]
,[DWH_Update_Date]
--,Brand
FROM [DW DataMart 2015].[DWH].[LU_Product]
where 1=1
--and ProductGroup like 'POST%'
--and Product_Code in ( '5500021','chr14','o5500021')
--and Dealer_Id in (3,7)
--  and BRAND is not null
--  and Product_Desc like '%GREEN%BLACK%'

) XXXX group by XXXX.ProductGroup, XXXX.Product_Code

order by 2,1,3
--order by 4,3
