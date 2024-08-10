# Variables
CROSS_COMPILE ?=
CC := $(CROSS_COMPILE)gcc
CFLAGS := -Wall -Wextra -O2
TARGET := writer
SRC := writer.c
OBJ := $(SRC:.c=.o)

# Default target to build the application
all: $(TARGET)

# Build target
$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Object file rule
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean target to remove the application and object files
clean:
	rm -f $(TARGET) $(OBJ)

# Ensure that CROSS_COMPILE uses the correct path if specified
ifeq ($(CROSS_COMPILE), aarch64-none-linux-gnu-)
CROSS_COMPILE := /home/wanghui/workspace/repos/cross_compile/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/$(CROSS_COMPILE)
endif

.PHONY: all clean

