# mysql

To Check which table is taking more space: (It will check even orphan table)
```
du -d1 -h /var/lib/mysql/naprwvtaxc/* 2>/dev/null | awk '$1 ~ /G/'
```


