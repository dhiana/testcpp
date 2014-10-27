CC=g++
MKDIR_P = mkdir -p

ifeq ($(DEBUG),yes)
	CXXFLAGS=-Wall -g
	LDFLAGS=-Wall -g
else
	CXXFLAGS=-Wall
	LDFLAGS=-Wall
endif

INCPATH=inc
SRCPATH=src
OBJPATH=obj
LIBPATH=lib
BINPATH=bin

SRC=$(SRCPATH)/hello.cpp \
	$(SRCPATH)/main.cpp
OBJ=$(OBJPATH)/hello.o \
	$(OBJPATH)/main.o
EXEC=$(BINPATH)/hello

TESTSRC=$(SRCPATH)/factorial.cpp
TESTOBJ=$(OBJPATH)/factorial.o
TESTEXEC=$(BINPATH)/factorial

INCLUDES=-I ./$(INCPATH)

default: directories $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(OBJPATH)/%.o: $(SRCPATH)/%.cpp $(INCPATH)/hello.h
	$(CC) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: clean cleanall test directories

test: directories $(TESTEXEC)
	./$(TESTEXEC) -s

$(TESTEXEC): $(TESTOBJ)
	$(CC) $(LDFLAGS) -o $@ $^
	$(CC) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	rm -f $(OBJPATH)/*.o

cleanall: clean
	rm -f $(EXEC)

directories:
	$(MKDIR_P) $(BINPATH) $(OBJPATH) $(LIBPATH)
