CC = gcc
AS = as
CFLAGS = -Wall -g -no-pie
LDFLAGS = -no-pie
ASFLAGS = 

# Targets
TARGET = test_STD
TEST_T_TARGET = test_t
OBJS = lab3_lib_main.o test_STD.o
TEST_T_OBJS = test_t.o

# Default target
all: $(TARGET) $(TEST_T_TARGET)

# Link the object files to create the executable
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

# Compile the C source file to an object file
test_STD.o: test_STD.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Assemble the assembly source file to an object file
lab3_lib_main.o: lab3_lib_main.s
	$(AS) $(ASFLAGS) -o $@ $<

# Assemble the test_t.s file to an object file
test_t.o: test_t.s
	$(AS) $(ASFLAGS) -o $@ $<

# Link the test_t object file to create the executable
$(TEST_T_TARGET): $(TEST_T_OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

# Run the tests
test: $(TARGET)
	./$(TARGET)

# Run the special test for test_t
test_t: $(TEST_T_TARGET)
	./$(TEST_T_TARGET)

# Clean up the build files
clean:
	rm -f $(OBJS) $(TEST_T_OBJS) $(TARGET) $(TEST_T_TARGET)

.PHONY: all clean test test_t