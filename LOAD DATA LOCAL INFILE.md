### Resolving Permission Errors
If you encountered a "Permission denied" error, it likely means the MySQL server does not have the required permissions to access the file. Using `LOAD DATA LOCAL INFILE` bypasses this by directing MySQL to retrieve the file from the client machine instead of the server.

### Understanding `LOAD DATA LOCAL INFILE`

The `LOCAL` keyword in the `LOAD DATA INFILE` command specifies that the file being loaded resides on the client machine (where the MySQL client is running) rather than on the server. By default, `LOAD DATA INFILE` expects the file to be located on the server itself.


### Steps to Use `LOAD DATA LOCAL INFILE`

#### 1. Create a Table (Example)
```sql
CREATE TABLE bxawrcmrhe.january2023 (
  column1 INT,
  column2 VARCHAR(50),
  column3 DATE
);
```

#### 2. Verify User Permissions
```sql
SHOW GRANTS FOR 'bxawrcmrhe'@'%';
```
Ensure the user has `ALL PRIVILEGES` on the database.

#### 3. Enable `local_infile`
```sql
SHOW VARIABLES LIKE 'local_infile';
```
If the value is `OFF`, enable it by modifying the MySQL configuration file (`my.cnf` or `my.ini`) and adding:
```ini
[mysqld]
local_infile=1
```
Then restart the MySQL server.

#### 4. Import Data from a Local File
```sql
LOAD DATA LOCAL INFILE '/home/579559.cloudwaysapps.com/bxawrcmrhe/public_html/wp-content/uploads/wpallimport/files/1.csv'
INTO TABLE january2023
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### Troubleshooting: MySQL Access Denied Issue

If customer says that I was able to do that using the mysql command line tool but I want to be able to do the same using php code, then add below to the php-fpm settings.

```ini
php_admin_value[mysqli.allow_local_infile] = 1
```
And make sure that all previlidges are assigned to the user:

Grants all available privileges on the `bxawrcmrhe` database to the user `thomas`.
```sql
GRANT ALL PRIVILEGES ON bxawrcmrhe.* TO 'thomas'@'%';
```

```sql
SHOW GRANTS FOR 'bxawrcmrhe'@'%';
```

### Apply Changes
Flushes privileges to ensure changes take effect.
```sql
FLUSH PRIVILEGES;
```


This ensures the user can execute `LOAD DATA LOCAL INFILE` successfully.

