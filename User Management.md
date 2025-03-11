# MySQL User Management Scenarios

## 1. Create a User with Read-Only Access

### Create a User
Creates a new MySQL user with a specified password.
```
CREATE USER 'thomas'@'%' IDENTIFIED BY 'EEG5vU8GkV@123!';
```

### Grant Read-Only Permission
Grants `SELECT` (read-only) permission on the `gxkfukcska` database to the user `thomas`.
```sql
GRANT SELECT ON gxkfukcska.* TO 'thomas'@'%';
```

### Verify Permissions
Shows the permissions assigned to the user `thomas`.
```sql
SHOW GRANTS FOR 'thomas'@'%';
```

### Alter Or Update User Password
Updates the password for the user `thomas`.
```sql
ALTER USER 'thomas'@'%' IDENTIFIED BY 'EEG5vU8GkV@123!';
```

### Apply Changes
Flushes privileges to ensure changes take effect.
```sql
FLUSH PRIVILEGES;
```

## 2. Assign Specific Permissions to the User
Grants a set of specific privileges on the `nxmhpzuwuz` database.
```sql
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON nxmhpzuwuz.* TO 'thomas'@'%';
```

## 3. Assign ALL Permissions to the User
Grants all available privileges on the `myczgrvswn` database to the user `thomas`.
```sql
GRANT ALL PRIVILEGES ON myczgrvswn.* TO 'thomas'@'%';
```

## 4. List and Manage Users

### List Specific Users in a Database
Retrieves users associated with a specific database (`gxkfukcska`).
```sql
SELECT User, Host FROM mysql.db WHERE Db = 'gxkfukcska';
```

### Delete a Specific User
Removes the user `rizwan.s` from MySQL.
```sql
DROP USER 'rizwan.s'@'%';
```

### List All Users Across Databases
Displays all users in MySQL.
```sql
SELECT user, host FROM mysql.user;
```

