#   Carlos Javier Martinez Polanco 201709282
#   Douglas Alexander Soch Catalán 201807032
#   Carlos Eduardo Soto Marroquín  201902502

##  Práctica 1 Laboratorio de sistemas de bases de datos 2
### BACKUPS

## Comandos utilizados

### Full Backup
```console
mysqldump -u USUARIO -pCONTRASEÑA DB > Ruta/nombre_fullbackup.sql
```

### Backup de una tabla
```console
mysqldump -u USUARIO -pCONTRASEÑA DB TABLA > Ruta/incremental_backup_tabla.sql
```

### Backup de una porción de datos
```console
mysqldump -u USUARIO -pCONTRASEÑA DB TABLA --no-create-info --where="id > N" > Ruta/incremental2.sql
```

### Restaurar Backup
```console
Comando: mysql -u USUARIO -pCONTRASEÑA db < Ruta/nombre_backup.sql
```