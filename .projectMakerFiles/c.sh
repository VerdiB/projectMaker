#! /bin/bash

projectName=$1
compiler=$2
syntaxVersion=""
extension=""
main_content=""
config=.projectMakerFiles/config
make=$(grep -E "^MAKE_TYPE" $config | cut -d '=' -f2)

if [ $compiler == "g++" ]; then
	extension="cpp"
	syntaxVersion=$(grep -E "^CPP_VERSION" $config | cut -d '=' -f2-)

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
	syntaxVersion=$(grep -E "^C_VERSION" $config | cut -d '=' -f2-)

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

cp .projectMakerFiles/$make $projectName/

sed -i -e "s/PLACEHOLDER_COMPILER/$compiler/g" "$projectName/$make"
sed -i -e "s/PLACEHOLDER_SYNTAX_VERSION/$syntaxVersion/g" "$projectName/$make"
sed -i -e "s/PLACEHOLDER_PROJECT_NAME/$projectName/g" "$projectName/$make"
sed -i -e "s/PLACEHOLDER_EXTENSION/$extension/g" "$projectName/$make"

echo "$main_content" > $projectName/src/main.$extension