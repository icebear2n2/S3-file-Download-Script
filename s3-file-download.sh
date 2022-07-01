#!/bin/bash

SAVE_PATH="<SAVE-PATH>"
PATH=$(echo "${Key}" | tr -d '"')
FILE=$(echo "${Key}" | cut -d '/' -f3 | tr -d '"')

count=0

awsCLI() {
    aws s3 cp s3://<S3-Bucket>/$PATH $SAVE_PATH/$FILE --endpoint "<ENDPOINT-URL>"
}

while IFS=',' read Key LastModified ETag Size StorageClass OwnerDisplayName OwnerID
do
    count=$(($count+1))
    if [ $count -ge 2 ]
    then
        if [ -e $SAVE_PATH/$FILE ]
        then
            echo "the $FILE exists in $SAVE_PATH."
            continue
        else
            echo "Downloading $FILE . . ."
            awsCLI
        fi
    else
        continue
    fi
done
