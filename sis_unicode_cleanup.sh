#!/bin/sh

timestamp=$(date +%s)
now=$(date)
server="lib ftp" #replace with server

cd /home/eprieto/sis

#grab file
#scp $server:$dir/$(ssh $server 'ls -t $dir | head -1') .

sftp $server <<EOF
cd /home/eprieto502/alma/student
lcd /home/eprieto/sis/
get exl_students.zip
exit
EOF

#backup the original file
if [ -f "/home/eprieto/sis/exl_students.zip" ]
then
    cp /home/eprieto/sis/exl_students.zip /home/eprieto/sis/backups/exl_students.zip-$timestamp
else
    touch /home/eprieto/sis/error.log
    echo "no file -  $now" >> /home/eprieto/sis/error.log
fi

#unzip and delete the zip
unzip -j /home/eprieto/sis/exl_students.zip
rm /home/eprieto/sis/exl_students.zip
mv /home/eprieto/sis/exl_students.xml /home/eprieto/sis/exl_students2.xml


#perl command to remove invalid xml characters
iconv -f UTF-8 -t UTF-8 -c /home/eprieto/sis/exl_students2.xml > /home/eprieto/sis/exl_students.xml
perl -CSDA -i -pe's/[^\x9\xA\xD\x20-\x{D7FF}\x{E000}-\x{FFFD}\x{10000}-\x{10FFFF}]+//g;' /home/eprieto/sis/exl_students.xml

#zip the file
zip exl_students exl_students.xml
rm /home/eprieto/sis/exl_students.xml
rm /home/eprieto/sis/exl_students2.xml

#copy back to lib ftp
#scp exl_students.zip $server:$dir

if [ -f "/home/eprieto/sis/exl_students.zip" ]
then
   cp /home/eprieto/sis/exl_students.zip /home/eprieto/sis/backups/exl_students-$timestamp-fixed
else
   touch /home/eprieto/sis/error.log
   echo "file after fix missing - $now" >> /home/eprieto/sis/error.log
fi

sftp $server <<EOF
cd /home/eprieto502/alma/student
lcd /home/eprieto/sis
put exl_students.zip
exit
EOF

#remove the file
rm /home/eprieto/sis/exl_students.zip


