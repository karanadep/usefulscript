#!/bin/bash
# Backup script to copy Configurations, Database (Hive, Hue, Ambari)
DB_BACKUP="/backups/mysql_backup/`date +%Y-%m-%d`"
DB_USER="<user>"
DB_PASSWD="<password>"
HN=`hostname | awk -F. '{print $1}'`

# Create the backup directory
mkdir -p $DB_BACKUP

# Remove backups older than 10 days
find /backups/mysql_backup/ -maxdepth 1 -type d -mtime +10 -exec rm -rf {} \;

# Perform Backups - Backup each database on the system using a root username and password
for db in $(mysql --user=$DB_USER --password=$DB_PASSWD -e 'show databases' -s --skip-column-names|grep -vi information_schema);
do mysqldump --user=$DB_USER --password=$DB_PASSWD --opt $db | gzip > "$DB_BACKUP/mysqldump-$HN-$db-$(date +%Y-%m-%d).gz";
done

# Change permission on this file to 700 and add entry in cron
crontab -e
30 01 * * * /usr/local/bin/mysql_backup.sh 2>&1 >> /usr/local/bin/mysql_backup.log

