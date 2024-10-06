#!/bin/bash

#$1 = name
#$2 = table name

init() {
    [ ! -d "routes" ] && mkdir "routes"
    [ ! -d "models" ] && mkdir "models"
    [ ! -d "controllers" ] && mkdir "controllers"
    [ ! -d "config" ] && mkdir "config"
    [ ! -d "constants" ] && mkdir "constants"
    [ ! -d "types" ] && mkdir "types"
    [ ! -d "templates" ] && mkdir "templates"
    [ ! -d "sockets" ] && mkdir "types"
    [ ! -d "utils" ] && mkdir "utils"

    create_file "templates/config.txt" "config" "json" ""
    create_file "templates/db.config.txt" "config" "ts" "db."
    sed "s/\[APPNAME\]/$1/g;"  "templates/package.txt" >"package.json"
    cp "templates/tsconfig.txt" "tsconfig.ts"
}

create_route() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/route_template.txt" "" "ts" $FILE_NAME; then
        echo "File '$FILE_NAME' route created successfully."
    else 
        echo "Error: Route Template file not found."
    fi
}

create_controller() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/controller_template.txt" "Controller" "ts" $FILE_NAME; then
        echo "File '$FILE_NAME' controller created successfully."
        create_route $1
    else 
        echo "Error: Controller Template file not found."
    fi
}

create_repository() {
    NAME="$1"
    FILE_NAME="$(echo "${NAME:0:1}" | tr '[:lower:]' '[:upper:]')$(echo "${NAME:1}" | tr '[:upper:]' '[:lower:]')"
    if create_file "templates/repository_template.txt" "Model" "ts" $FILE_NAME $2; then
        echo "File '$FILE_NAME' repository created successfully."
        create_controller $1
    else 
        echo "Error: Repository Template file not found."
    fi
}

create_file(){
    TITLENAME="s/\[TITLENAME\]/$4/g;"
    TABLE_NAME=""
    ROUTE_TEMPLATE="$1"
    ROUTE_FORMAT="$2"
    DIRECTORY_NAME=""
    EXTENSIONS="$3"

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
        TABLE_NAME="s/\[TABLENAME\]/$5/g;"
    fi

    if [ -f "$ROUTE_TEMPLATE" ]; then
        while IFS= read -r line
        do
            echo "$line" | sed "$TITLENAME $TABLE_NAME" >> "$DIRECTORY_NAME/$4$ROUTE_FORMAT.$3"
        done < "$ROUTE_TEMPLATE"
        return 0;
    else
        return 1;
    fi
}