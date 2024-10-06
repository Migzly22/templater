#!/bin/bash

# Import functions from functions.sh
source ./main_function.sh

#Check if the parameter is greater than 2 or equal
if [ $# -lt 2 ]; then
  echo "Usage: $0 <param1> <param2> ... <paramN>"
  exit 1
fi

CREATE_TYPE="$1"
FILE_NAME="$2"
TABLE_NAME="$3"

case $CREATE_TYPE in
  "create-route")
    create_route $FILE_NAME
    ;;
  "create-controller")
    create_controller $FILE_NAME
    ;;
  "create-repository")
    create_repository $FILE_NAME $TABLE_NAME
    ;;
  "init")
    init $2
    ;;
  *)
    echo "You entered an invalid command."
    ;;
esac