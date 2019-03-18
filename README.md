# sis-unicode-cleanup
## sis_unicode_cleanup.sh
The cleanup script is used to remove invalid unicode characters entered into the student ingestion file. It pulls the file from lib ftp, removes the invalid unicode characters using perl, and sends the file back. 

## cron
 Shell script runs every day at 1:40am via cron.  The second command deletes backups older than 30 days.

