#!/bin/bash

# Display a helper message if the user hasn't provided args
if [ "$#" == 0 ]
then
    echo -e "This script has args: \n '#1' -> Lambda Layer name. \n '#2' -> requirements.txt name (if not default) \n '#3' -> no-deps: will prevent dependencies not specified from being installed. \nPlease try again with the args provided. Exiting."
    exit
fi


if [ "$2" == "requirements.txt" ] || [ "$2" == "" ]
then
    REQUIREMENTS_FILENAME="requirements.txt"
else
    REQUIREMENTS_FILENAME="$2"
fi

if [[ ! -f REQUIREMENTS_FILENAME ]]
    echo -e "The requirements.txt you specified (arg #2) was not found. Exiting."
    exit



export PKG_DIR="$1/python/lib/python3.7/site-packages"

rm -rf ${PKG_DIR} && mkdir -p ${PKG_DIR}



if [ "$3" == "no-deps" ]
then
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r requirements.txt --no-deps -t ${PKG_DIR}
else
    echo "This will drag in all dependencies. Be sure to check the size before deploying."
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r requirements.txt -t ${PKG_DIR}
fi


