#!/bin/bash
docker run --rm -itp 8080:8080 $(docker build -q .)
echo "The Docker instance is running on port 8080"
