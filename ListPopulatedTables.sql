#This TSQL query lists all tables in a database which are not empty

SELECT
	t.name table_name,
	s.name schema_name,
	sum(p.rows) total_rows
FROM
	sys.tables t
	join sys.schemas s on (t.schema_id = s.schema_id)
	join sys.partitions p on (t.object_id = p.object_id)
WHERE p.index_id in (0,1)
--and t.name LIKE '%log%'
GROUP BY t.name,s.name
HAVING sum(p.rows) > 100
ORDER BY total_rows desc
