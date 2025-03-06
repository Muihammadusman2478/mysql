# mysql

### To check which table is taking more space: (It will check even orphan table)
```
du -d1 -h /var/lib/mysql/naprwvtaxc/* 2>/dev/null | awk '$1 ~ /G/'
```

### To grep the table "yotpo_order_status_history"
```
mysql -u naprwvtaxc -p -e "SHOW TABLES FROM naprwvtaxc" | grep 'yotpo_order_status_history'

```


### To get the row count of a table "sales_order_item"
```
SELECT COUNT(*) FROM sales_order_item;
```

### To check the size of all databases and list them in order from largest to smallest
```
SELECT table_schema AS "Database",
       ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS "Size (GB)"
FROM information_schema.tables
GROUP BY table_schema
ORDER BY SUM(data_length + index_length) DESC;
```

### To get the specific apps DB size in MBs: (Replace DB Name)
```
SELECT table_schema AS "Database",
       SUM(data_length + index_length) / 1024 / 1024 AS "Size (MB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
GROUP BY table_schema;
```

### To get the specific apps DB size in GBs: (Replace DB Name)
```
SELECT table_schema AS "Database",
       SUM(data_length + index_length) / 1024 / 1024 / 1024 AS "Size (GB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
GROUP BY table_schema;
```

### To list the tables in the "naprwvtaxc" database along with their sizes in GB

```
SELECT table_name AS "Table",
       ROUND(((data_length + index_length) / 1024 / 1024 / 1024), 2) AS "Size (GB)"
FROM information_schema.tables
WHERE table_schema = "naprwvtaxc"
ORDER BY (data_length + index_length) DESC;
```

### To check Buffer Pool Size In GBs

```
mysql -e "SELECT @@innodb_buffer_pool_size / 1024 / 1024 / 1024 AS buffer_pool_size_GB;"
```


```
Your code here
```

```
Your code here
```


