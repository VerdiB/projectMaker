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

TARGET := \$(MY_PATH)PLACEHOLDER_PROJECT_NAME

# LDLIBS := `pkg-config --libs glib-2.0` # adds libraries to the linker
LDLIBS := ``
# CFLAGS_LIB := `pkg-config --cflags glib-2.0`
CFLAGS_LIB := ``

SRCS_DIR := src/

SRCS := $(wildcard $(SRCS_DIR)/*.PLACEHOLDER_EXTENSION) $(wildcard $(SRCS_DIR)/*.h)
# SRCS += $(wildcard *.c)
# SRCS += $(wildcard *.hpp)
# SRCS += $(wildcard *.h)
# SRCS := $(filter-out unittest.cpp, $(SRCS))
all: $(TARGET)

$(TARGET): $(SRCS)
	mkdir -p $(MY_PATH)
	$(CC) $(CFLAGS) $(CFLAGS_LIB) -o $@ $^ $(LDLIBS)

fmt:
	clang-format -style='{BasedOnStyle: GNU, PointerAlignment: Left}' -i $(SRCS)

chk:
	cppcheck -q  --check-config --enable=all --max-ctu-depth=2 --inconclusive --output-file=cppcheck.log -$(SYNTAX_VERSION) .
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind.log ./$(TARGET)

clean:
	rm -rf $(TARGET)

.PHONY: all fmt chk clean