#! /bin/bash

projectName=$1
compiler=$2
syntaxVersion=$3
extension=""
main_content=""

if [ $compiler == "g++" ]; then
	extension="cpp"

	main_content=$(cat << 'EOF'
#include <iostream>

int main(int argc, char *argv[]) {
	std::cout << "Hello World" << std::endl;
	return 0;
}
EOF
)

elif [ $compiler == "gcc" ]; then
	extension="c"

	main_content=$(cat << 'EOF'
#include <stdio.h>

int main(int argc, char** argv) {
	printf("Hello World\n");
	return 0;
}
EOF
)

else
	echo "Compiler not supported"
	exit 1
fi

touch ./$projectName/src/main.$extension

touch ./$projectName/Makefile

echo "$main_content" > $projectName/src/main.$syntax