#!/bin/sh

# Check if the filename parameter is passed
if [ -z "$1" ]; then
  echo "Error: No filename parameter provided."
  echo "Usage: ./script.sh <new_filename>"
  exit 1
fi

# Specify the source file
ROUTE_TEMPLATE="route_template.txt"

# Get the parameter
FILE_NAME="$1"

# Check if the template file exists
if [ -f "$ROUTE_TEMPLATE" ]; then
  # Create a new file and write the contents of the template file to it
  while IFS= read -r line
  do
    # echo "$line" | sed "s/\[CHANGEME\]/$FILE_NAME/g" >> "$FILE_NAME.txt"
    echo "$line" | sed "s/\[CHANGEME\]/$FILE_NAME/g; s/TWOME/2/g" >> "$FILE_NAME.txt"
  done < "$ROUTE_TEMPLATE"
  
  echo "File '$FILE_NAME' created successfully with the contents of '$ROUTE_TEMPLATE'."
else
  echo "Error: Template file '$ROUTE_TEMPLATE' not found."
fi
