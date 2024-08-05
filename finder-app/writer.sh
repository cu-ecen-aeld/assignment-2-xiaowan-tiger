#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo " Usage: writer.sh <path_to_file> <file_contents>"
    exit 1
fi

writefile=$1
writestr=$2

dirname=$(dirname -- "$writefile")

mkdir -p -- "$dirname"

if ! echo "$writestr" > "$writefile"; then
    echo "Error: creat or write to $writefile fail! "
fi

echo "File create/updated successfully!"
