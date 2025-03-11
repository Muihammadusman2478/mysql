# MySQL Recovery Guide

## **1. List the Application Names and Count**
```sh
cd /home/master/applications/  && ls -l | grep '^d'| awk '{print $NF}'  | wc -l
```

## **2. Check the Database File Size of All Applications**
```sh
cd /var/lib/mysql && ls -ld ?????????? | grep '^d'| awk '{print $NF}' | du -sch ??????????
```

---

# **Recover Crashed MySQL**

## **Step 1: Start MySQL in Recovery Mode**
Modify `/etc/mysql/conf.d/custom-manual.cnf` and set a recovery mode level:
```ini
innodb_force_recovery = n
```
- Replace `n` with values between `1-6`, starting from `1` and increasing if necessary.
- Try connecting to MySQL using:
```sh
mysql
```

Once connected, check the database sizes:
```sql
SELECT table_schema AS "Database", ROUND(SUM(data_length + index_length) / 1024 / 1024 / 1024, 2) AS "Size (GB)"
FROM information_schema.tables GROUP BY table_schema ORDER BY SUM(data_length + index_length) DESC;
```

## **Step 2: Export/Dump All Databases**

### **Take a Backup of All Databases**
```sh
cd /home/master && mkdir db && cd db
```
Run the following command to dump all databases:
```sh
for db in $(mysql -e "SHOW DATABASES;" | tr -d "| " | grep -v Database); do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]]; then
        echo "Dumping database: $db"
        mysqldump --databases $db > $db.sql
    fi
done
```

### **Exclude Specific Databases While Dumping**
Modify the script to exclude `egxycgwevn` and `ydaycgwevn`:
```sh
for db in $(mysql -e "SHOW DATABASES;" | tr -d "| " | grep -v Database); do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] && [[ "$db" != "egxycgwevn" ]] && [[ "$db" != "ydaycgwevn" ]]; then
        echo "Dumping database: $db"
        mysqldump --databases $db > $db.sql
    fi
done
```

## **Step 3: Remove Old Database Files**
```sh
cd /var/lib/mysql/
rm -rf `ls -d /var/lib/mysql/* | grep -v "/var/lib/mysql/mysql"`
```

## **Step 4: Remove Recovery Mode Setting**
Edit `/etc/mysql/conf.d/custom.cnf` and remove:
```ini
innodb_force_recovery = 5
```

## **Step 5: Restart and Fix MariaDB**
```sh
service mysql stop
service mysql start
```
Clean up MySQL system tables:
```sh
cd /var/lib/mysql/mysql
rm gtid_slave_pos.*
rm innodb_index_stats.*
rm innodb_table_stats.*
```
Restart and upgrade MySQL:
```sh
service mysql restart
mysql_upgrade --force
```

## **Step 6: Create Databases and Import Data**
### **Create Missing Databases**
Generate the commands to create databases:
```sh
cd /home/master/db
for file in *.sql; do echo "create database ${file%.sql};"; done
```
Run the output inside MySQL.

### **Import Databases**
Generate the import commands:
```sh
for file in *.sql; do echo "mysql ${file%.sql} < $file"; done
```
Run the output under `/home/master/db`.

*Good Alternate Option To Import all the DBs at once*
```sql
for i in $(ls -l ../applications/ | grep '^d'| awk '{print $NF}'); do     mysql $i < /home/master/db/$i.sql; done
```


## **Step 7: Verify Users**
Check MySQL users:
```sql
SELECT user,host FROM mysql.user;
```

---

# **Restore Database from Remote Server**
### **Prepare for Download**
**Make sure `/home/master/db/` is empty** before proceeding.

### **Download Backups from Remote Server**
```sh
cd /home/master && mkdir db && cd db
for i in $(ls -l ../applications/ | grep '^d'| awk '{print $NF}'); do
    mkdir $i; /var/cw/scripts/bash/duplicity_restore.sh --src $i -d --dst /home/master/db/$i --time '2024-02-07';
done
```

### **Import All Databases**
```sh
for i in $(ls -l ../applications/ | grep '^d'| awk '{print $NF}'); do
    mysql $i < /home/master/db/$i/mysql/$i-*.sql;
done
```

---

## **MySQL Recovery Process Complete!** 🚀


