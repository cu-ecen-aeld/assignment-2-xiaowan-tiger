#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Usage: finder.sh <path to search> <search string>."
    exit 1
fi

filesdir=$1
searchstr=$2

if [ ! -d "$filesdir" ]; then 
    echo "The directory $filesdir does not exist."
    exit 1
fi

num_files=$(find "$filesdir" -type f | wc -l)
num_lines=$(grep -r "$searchstr" "$filesdir" | wc -l)

echo "seaching $searchstr in $filesdir, result is:"
echo "The number of files are $num_files and the number of matching lines are $num_lines"
