pg_dump -U usuario -h localhost -F c -b -v -f backup_base_datos.backup base_datos

pg_restore -U usuario -h localhost -d base_datos -v backup_base_datos.backup

crontab -e

# Agregar la siguiente línea para ejecutar el backup a las 2:00 AM todos los días:
0 2 * * * pg_dump -U usuario -h localhost -F c -b -v -f /backups/backup_$(date +\%Y\%m\%d).backup base_datos