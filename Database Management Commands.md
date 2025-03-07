# MySQL Database Management Commands

### Create a Database

```sql
CREATE DATABASE jahxxhdjxe;

GRANT ALL PRIVILEGES ON jahxxhdjxe.* TO 'jahxxhdjxe'@'%' IDENTIFIED BY 'ppGbKhYM39';
FLUSH PRIVILEGES;
```

### Drop a Database

```sql
DROP DATABASE dbname;
```

### Truncate a Table

```sql
TRUNCATE TABLE table_name;
```


### Check Which Table is Taking More Space
Lists tables consuming significant storage in the `naprwvtaxc` database.
```sql
du -d1 -h /var/lib/mysql/naprwvtaxc/* 2>/dev/null | awk '$1 ~ /G/'
```
*Alternate:*

```sql
read -p "Enter database name: " db_name; du -d1 -h /var/lib/mysql/$db_name/* 2>/dev/null | awk '$1 ~ /G/'
```

### Grep a Specific Table in a Database
Searches for `yotpo_order_status_history` table in `naprwvtaxc`.
```sql
mysql -u naprwvtaxc -p -e "SHOW TABLES FROM naprwvtaxc" | grep 'yotpo_order_status_history'
```

*Alternate:*

```sql
read -p "Enter database name: " db_name; read -p "Enter table name: " table_name; mysql -u root -p -e "SHOW TABLES FROM $db_name" | grep "$table_name"
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

