#!/bin/bash

#$1 = name
#$2 = table name

create_route() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/route_template.txt" "" $FILE_NAME; then
        echo "File '$FILE_NAME' route created successfully."
    else 
        echo "Error: Route Template file not found."
    fi
}

create_controller() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/controller_template.txt" "Controller" $FILE_NAME; then
        echo "File '$FILE_NAME' controller created successfully."
        create_route $1
    else 
        echo "Error: Controller Template file not found."
    fi
}

create_repository() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/repository_template.txt" "Model" $FILE_NAME $2; then
        echo "File '$FILE_NAME' repository created successfully."
        create_controller $1
    else 
        echo "Error: Repository Template file not found."
    fi
}

create_file(){
    TITLENAME="s/\[TITLENAME\]/$3/g;"
    TABLE_NAME=""
    ROUTE_TEMPLATE="$1"
    ROUTE_FORMAT="$2"
    DIRECTORY_NAME=""

    case $ROUTE_FORMAT in 
        "")
            DIRECTORY_NAME="route"
        ;;
        *)
            DIRECTORY_NAME="$(echo "${ROUTE_FORMAT}" | tr '[:upper:]' '[:lower:]')"
        ;;
    esac

    [ ! -d "$DIRECTORY_NAME" ] && mkdir "$DIRECTORY_NAME"

    if [ $# -ge 4 ]; then
        TABLE_NAME="s/\[TABLENAME\]/$4/g;"
    fi

    if [ -f "$ROUTE_TEMPLATE" ]; then
        while IFS= read -r line
        do
            echo "$line" | sed "$TITLENAME $TABLE_NAME" >> "$DIRECTORY_NAME/$3$ROUTE_FORMAT.ts"
        done < "$ROUTE_TEMPLATE"
        return 0;
    else
        return 1;
    fi
}