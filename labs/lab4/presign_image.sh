#! /bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: ./presign_image <file name> <bucket name> <expiration time>"
  exit 1
fi

FILENAME=$1
BUCKET=$2
EXPIRATION=$3

aws s3 cp "$FILENAME" "s3://$BUCKET/"

echo "File uploaded successfully to s3://$BUCKET/$FILENAME"

URL=$(aws s3 presign --expires-in "$EXPIRATION" "s3://$BUCKET/$FILENAME")

echo "$URL"
