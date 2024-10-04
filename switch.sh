#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Usage: $0 <param1> <param2> ... <paramN>"
  exit 1
fi

CREATE_TYPE="$1"
FILE_NAME="$2"

case $CREATE_TYPE in
  "create-route")
    echo "You entered a number between 1 and 3."
    ;;
  "create-model")
    echo "You entered a number between 4 and 6."
    ;;
  "create-repository")
    echo "You entered a number between 7 and 10."
    ;;
  *)
    echo "You entered an invalid command."
    ;;
esac