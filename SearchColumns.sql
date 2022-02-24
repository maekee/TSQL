#This query searches for matching column names in Tables and Views

SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%SEARCHWORDHERE%'
ORDER BY    TableName,ColumnName
