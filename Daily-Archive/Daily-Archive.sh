#! /bin/bash
DATE=$(date +%y%m%d)
FILE_NAME=archive${DATE}.tar.gz
CONFIG_FILE=~/archive/backup_files_list
DESTINATION=~/archive/$FILE_NAME

# check the existence of the config-file
if [ -f $CONFIG_FILE ]
then 
    echo
else 
    echo $CONFIG_FILE does not exists!
    echo Backup failed
    exit
fi 

FILE_NO=1
# input from $CONFIG_FILE
exec < $CONFIG_FILE
read FILE_NAME
while [ $? -eq 0 ]
do
    if [ -f "$FILE_NAME" -o -d "$FILE_NAME" ]
    then 
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        echo
        echo $FILE_NAME, does not exists.
    fi

    FILE_NO=$[$FILE_NO + 1]
    read FILE_NAME
done

echo Start archiving...
echo
# pack and compress the files and directories
tar -zcf $DESTINATION $FILE_LIST 2> /dev/null

echo Archive complete!
echo Archive file is: $DESTINATION
echo

exit

