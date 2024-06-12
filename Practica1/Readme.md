#   Carlos Javier Martinez Polanco 201709282
#   Douglas Alexander Soch Catalán 201807032
#   Carlos Eduardo Soto Marroquín  201902502

##  Práctica 1 Laboratorio de sistemas de bases de datos 2
### BACKUPS

## Comandos utilizados

### Full Backup
```console
mysqldump -u USUARIO -p CONTRASEÑA DB > Ruta/nombre_fullbackup.sql
```

### Incremental Backup
```console
mysqldump -u USUARIO -p CONTRASEÑA DB TABLA > Ruta/incremental_backup_tabla.sql
```

### Restaurar Backup
```console
Comando: mysql -u USUARIO -p CONTRASEÑA db < Ruta/nombre_backup.sql
```