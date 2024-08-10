#!/bin/sh
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat conf/username.txt)

if [ $# -lt 3 ]
then
	echo "Using default value ${WRITESTR} for string to write"
	if [ $# -lt 1 ]
	then
		echo "Using default value ${NUMFILES} for number of files to write"
	else
		NUMFILES=$1
	fi	
else
	NUMFILES=$1
	WRITESTR=$2
	WRITEDIR=/tmp/aeld-data/$3
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

rm -rf "${WRITEDIR}"

# create $WRITEDIR if not assignment1
assignment=`cat ../conf/assignment.txt`

if [ $assignment != 'assignment1' ]
then
	mkdir -p "$WRITEDIR"

	#The WRITEDIR is in quotes because if the directory path consists of spaces, then variable substitution will consider it as multiple argument.
	#The quotes signify that the entire string in WRITEDIR is a single string.
	#This issue can also be resolved by using double square brackets i.e [[ ]] instead of using quotes.
	if [ -d "$WRITEDIR" ]
	then
		echo "$WRITEDIR created"
	else
		exit 1
	fi
fi
#echo "Removing the old writer utility and compiling as a native application"
#make clean
#make

if [ $assignment = 'assignment2' ]
then

    AS2_DIR="$(dirname "$0")/../assignments/assignment2"

    # 切换到assignment2 dir
    #cd "$AS2_DIR" || { echo "目录切换失败: $AS2_DIR"; exit 1; }

    # 执行 make clean
    make -C "$AS2_DIR" clean

    # 执行 make
    make -C "$AS2_DIR"

    # 如果编译成功，将生成的 writer 文件拷贝到脚本所在目录
    if [ -f "$AS2_DIR/writer" ]; then
        cp "$AS2_DIR/writer" "$(dirname $0)/writer"
        echo "编译成功，writer 文件已复制到脚本所在目录"
    else
        echo "编译失败，未找到 writer 文件"
        exit 1
    fi

    #cd "$(dirname "$0")"
fi


for i in $( seq 1 $NUMFILES)
do
	./writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

# remove temporary directories
rm -rf /tmp/aeld-data

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
	exit 1
fi
