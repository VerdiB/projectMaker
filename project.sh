#! /bin/bash

projectName=$1
syntax=$2

mkdir -p $projectName/src

# syntaxVersion=""
# compiler=""

if [ $syntax == "cpp" ]; then
	# compiler="g++"
	# syntaxVersion="-std=c++20"
	source c.sh "$projectName" "g++" "-std=c++20"
elif [ $syntax == "c" ]; then
	# compiler="gcc"
	# syntaxVersion="-std=c99"
	source c.sh "$projectName" "gcc" "-std=c99"

elif [ $syntax == "py" ]; then
	# source py.sh "$projectName" "false"
	echo "todo py"

elif [ $syntax == "php" ]; then
	source php.sh "$projectName"
	echo "todo php improvements"

elif [ $syntax == "py-web" ]; then
	# source py.sh "true"
	echo "todo py-web"

else
	echo "Syntax not supported"
	exit 1
fi




code ./$projectName
