#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <URL>"
  exit 1
fi

URL="$1"
filename=$(basename $URL)

echo "Downloading $URL..."
curl -O "$URL"

if [ $? -ne 0 ]; then
    echo "Error downloading file."
    exit 1
fi

echo "Extracting $filename..."
tar -xzf "$filename"

TSV_FILE=$(find . -maxdepth 1 -type f -name "*.tsv")

if [ -z "$TSV_FILE" ]; then
    echo "No TSV file found in the fetched bundle."
    exit 1
fi

CSV_FILE="${TSV_FILE%.tsv}.csv"
echo "Converting $TSV_FILE to $CSV_FILE..."
tr '\t' ',' < $TSV_FILE > $CSV_FILE

echo "CSV file located at: $CSV_FILE"
