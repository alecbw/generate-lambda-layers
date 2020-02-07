#!/bin/bash
if [ "$1" == "" ]
then
    echo "You need to pass your LL Name as an argument"
    exit
fi

export PKG_DIR="$1/python/lib/python3.7/site-packages"

rm -rf ${PKG_DIR} && mkdir -p ${PKG_DIR}

if [ "$2" == "no-deps" ]
then
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r requirements.txt --no-deps -t ${PKG_DIR}
else
    echo "This will drag in all dependencies. Be sure to check the size before deploying."
    docker run --rm -v "$(pwd):/foo" -w /foo lambci/lambda:build-python3.7 \
    pip install -r requirements.txt -t ${PKG_DIR}
fi


