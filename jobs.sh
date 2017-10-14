#!/bin/sh
#
# OpenCATS Autobackup v0.0
# By Kevin Harper
# ResultsInternet.com
# kevinmharper@gmail.com
# 
# This script creates a MySQL backup and Gzips it, creates a full file backup
# and zips it, then deletes backups older than 7 days. Place it on a cron and
# schedule to your preferences.
#
# Set MySQL credentials
#
THEHOST="mysqlhost.com"
THEDB="mysql_db"
THEDBUSER="mysql_user"
THEDBPW="mysql_pass"
THEDATE=`date +%d%m%y%H%M`
#
# Set other variables
#
THESITE="livesite.com"
THEBACKUPPATH="/path/to/backups/"
THESITEPATH="/path/to/livesite.com"
#
# Make MySQL backup
#
mysqldump -h $THEHOST -u $THEDBUSER -p${THEDBPW} $THEDB | gzip > ${THEBACKUPPATH}${THESITE}_mysql_${THEDATE}.gz
#
# Make file backup
#
zip -r ${THEBACKUPPATH}${THESITE}_files_${THEDATE}.zip ${THESITEPATH}
#
# Remove backups older than 7 days
#
find ${THEBACKUPPATH}${THESITE}* -mtime +7 -exec rm {} \;
