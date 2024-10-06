#!/bin/bash

#Check if the parameter is greater than 2 or equal
if [ $# -lt 1 ]; then
  echo "Commit Message is Needed"
  exit 1
fi

git add .
git commit -m "$1"
git push