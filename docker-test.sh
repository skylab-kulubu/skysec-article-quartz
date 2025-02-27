#!/bin/bash

IMAGE_NAME=${IMAGE_NAME:-"skysec-article"}
AUTHOR_NAME=${AUTHOR_NAME:-"lomarkomar"}
VERSION=${VERSION:-"latest"}
PORT=${PORT:-"8080"}
docker image prune -f
docker build -t $AUTHOR_NAME/$IMAGE_NAME:$VERSION .
docker run --rm -itp $PORT:8080 $AUTHOR_NAME/$IMAGE_NAME:$VERSION
