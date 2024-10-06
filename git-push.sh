#!/bin/bash

#Check if the parameter is greater than 2 or equal
COMMIT=""
FILES=""
REPO=""

usage() {
    echo "Usage: $0 --commit <commit_msg> [--files <files_value>] [--repo <repo_value>]"
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --commit)  
            shift 
            COMMIT="$1"  
            shift 
            ;;
        --files)  
            shift  
            FILES="$1"  
            shift  
            ;;
        --repo)  
            shift  
            REPO="$1"  
            shift  
            ;;
        *)  
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

if [ -z "$FILES" ]; then
  FILES="."
fi
if [ -z "$REPO" ]; then
  REPO="master"
fi
if [ -z "$COMMIT" ]; then
  echo "Commit Message is Needed"
  exit 1
fi

git add $FILES
git commit -m "$COMMIT"
git push origin $REPO