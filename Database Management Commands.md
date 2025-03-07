# MySQL Database Management Commands

## 1. Checking Database and Table Sizes

### Check Which Table is Taking More Space
Lists tables consuming significant storage in the `naprwvtaxc` database.
```sql
du -d1 -h /var/lib/mysql/naprwvtaxc/* 2>/dev/null | awk '$1 ~ /G/'
```

### Find a Specific Table in a Database
Searches for `yotpo_order_status_history` table in `naprwvtaxc`.
```sql
mysql -u naprwvtaxc -p -e "SHOW TABLES FROM naprwvtaxc" | grep 'yotpo_order_status_history'
```

### Get the Row Count of a Table
Counts rows in the `sales_order_item` table.
```sql
SELECT COUNT(*) FROM sales_order_item;
```

### Check the Size of All Databases (Ordered from Largest to Smallest)
Retrieves database sizes and orders them in descending order.
```sql
SELECT table_schema AS "Database",
       ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS "Size (GB)"
FROM information_schema.tables
GROUP BY table_schema
ORDER BY SUM(data_length + index_length) DESC;
```

### Get the Size of a Specific Database in MBs
Retrieves size details for the `naprwvtaxc` database.
```sql
SELECT table_schema AS "Database",
       SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
GROUP BY table_schema;
```

### Get the Size of a Specific Database in GBs
Retrieves size details for the `naprwvtaxc` database in GBs.
```sql
SELECT table_schema AS "Database",
       SUM(data_length + index_length) / 1024 / 1024 / 1024 AS "Size (GB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
GROUP BY table_schema;
```

### List Tables in a Database Along with Their Sizes in GBs
Retrieves a list of tables in `naprwvtaxc` and their sizes.
```sql
SELECT table_name AS "Table",
       ROUND(((data_length + index_length) / 1024 / 1024 / 1024), 2) AS "Size (GB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
ORDER BY (data_length + index_length) DESC;
```

### Check InnoDB Buffer Pool Size in GBs
Displays the size of the InnoDB buffer pool.
```sql
mysql -e "SELECT @@innodb_buffer_pool_size / 1024 / 1024 / 1024 AS buffer_pool_size_GB;"
```

