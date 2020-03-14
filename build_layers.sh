#!/bin/bash

# Display a helper message if the user hasn't provided args
if [ "$#" == 0 ]
then
    echo -e "This script has args: \n '#1' -> Lambda Layer name. \n '#2' -> requirements.txt name (if not default) \n '#3' -> -no_deps: will prevent dependencies not specified from being installed. '#4' -> -deploy: will deploy after building. \nPlease try again with the args provided. Exiting."
    exit
fi

# Let the user pass a specific requirements filename if they want.
if [ "$2" == "requirements.txt" ] || [ "$2" == "" ]
then
    REQUIREMENTS_FILENAME="requirements.txt"
else
    REQUIREMENTS_FILENAME="$2"
fi

# Check if that requirements file exists, exit if not.
if [[ ! -f $REQUIREMENTS_FILENAME ]]
then
    echo -e "The requirements.txt you specified as arg 2 ($REQUIREMENTS_FILENAME) was not found. Exiting."
    exit
fi

# Make the folder structure necessary for the Lambda to read from the Layer
export PKG_DIR="$1/python/lib/python3.7/site-packages"
rm -rf ${PKG_DIR} && mkdir -p ${PKG_DIR}


# Be careful about deps - boto3 adds like 30 mb and you don't need it
if [ "$3" == "-no_deps" ] || [ "$4" == "-no_deps" ]
then
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r $REQUIREMENTS_FILENAME --no-deps -t ${PKG_DIR}
else
    echo "This will drag in all dependencies. Be sure to check the size before deploying."
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r $REQUIREMENTS_FILENAME -t ${PKG_DIR}
fi

if [ "$3" == "-deploy" ] || [ "$4" == "-deploy" ]
then
    echo "Make sure you added it to the serverless-layers.yml first!"
    sls deploy --config "serverless-layers.yml"
fi

# FYI the Lambda folder will compress about 3x in zipping before upload.
# Be aware the 250mb limit of LL's attached to a given Lambda is UN-zipped
