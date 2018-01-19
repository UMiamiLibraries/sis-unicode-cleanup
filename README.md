# sis-unicode-cleanup
The cleanup script is used to remove invalid unicode characters entered into the student ingestion file. The script runs every day at 1:40am via cron. It pulls the file from lib ftp, removes the invalid unicode characters using perl, and sends the file back. S second cron job deletes backups older than 30 days.

