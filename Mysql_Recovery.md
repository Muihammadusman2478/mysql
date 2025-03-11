

### List the Application Names and Count

```sql 
cd /home/master/applications/  && ls -l | grep '^d'| awk '{print $NF}'  | wc -l
```
```sql
cd /home/master/applications/  && ls -l | grep '^d'| awk '{print $NF}' 

!! | wc -l 
```
