#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <csv_with_spaces.csv> <new_filename.csv>"
  exit 1
fi

OLD_CSV=$1
NEW_FILENAME=$2

if [ ! -f "$OLD_CSV" ]; then
  echo "Error: File not found: '$OLD_CSV'."
  exit 1
fi

tr -s '\n' < $OLD_CSV > $NEW_FILENAME

echo "Blank lines removed. New file saved as '$NEW_FILENAME'."
