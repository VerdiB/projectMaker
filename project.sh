#! usr/bin/bash

projectName=$1
syntax=$2

mkdir $projectName && touch ./$projectName/main.$syntax

syntaxVersion=""
compiler=""

if [ $syntax == "cpp" ]; then
	compiler="g++"
	syntaxVersion="-std=c++17"
elif [ $syntax == "c" ]; then
	compiler="gcc"
	syntaxVersion="-std=c99"
else
	echo "Syntax not supported"
	exit 1
fi

makefile_content=$(cat << 'EOF'
CC := PLACEHOLDER_COMPILER
SYNTAX_VERSION := PLACEHOLDER_SYNTAX_VERSION
CFLAGS_DEBUG := -Wall -g -pthread $(SYNTAX_VERSION) -pedantic -O0
CFLAGS_RELEASE := -Wall -O3 -pthread $(SYNTAX_VERSION) -pedantic -s -DNDEBUG

# pthread for threading, seems to work on windows, neccessary for linux

ifeq ($(debug),1)
	CFLAGS := $(CFLAGS_DEBUG)
	MY_PATH := Debug/
else
	CFLAGS := $(CFLAGS_RELEASE)
	MY_PATH := Release/
endif

TARGET := \$(MY_PATH)$projectName

# LDLIBS := `pkg-config --libs glib-2.0` # adds libraries to the linker
LDLIBS := ``
# CFLAGS_LIB := `pkg-config --cflags glib-2.0`
CFLAGS_LIB := ``

SRCS := $(wildcard *.cpp)
SRCS += $(wildcard *.c)
SRCS += $(wildcard *.hpp)
SRCS += $(wildcard *.h)
# SRCS := $(filter-out unittest.cpp, $(SRCS))
all: $(TARGET)

$(TARGET): $(SRCS)
	mkdir -p $(MY_PATH)
	$(CC) $(CFLAGS) $(CFLAGS_LIB) -o $@ $^ $(LDLIBS)

fmt:
	clang-format -style='{PointerAlignment: Left}' -i $(SRCS)

chk:
	cppcheck -q  --check-config --enable=all --inconclusive -$(SYNTAX_VERSION) .
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind.log ./$(TARGET)

clean:
	rm -rf $(TARGET)

.PHONY: all fmt chk clean
EOF
)

makefile_content="${makefile_content/PLACEHOLDER_COMPILER/$compiler}"
makefile_content="${makefile_content/PLACEHOLDER_SYNTAX_VERSION/$syntaxVersion}"


echo "$makefile_content" > $projectName/Makefile

code ./$projectName
