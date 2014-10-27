CC=g++

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

INCLUDES=-I ./$(INCPATH)

default: directories $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(OBJPATH)/%.o: $(SRCPATH)/%.cpp $(INCPATH)/hello.h
	$(CC) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

.PHONY: clean cleanall directories

clean:
	rm -f $(OBJPATH)/*.o

cleanall: clean
	rm -f $(EXEC)

MKDIR_P = mkdir -p

directories:
	$(MKDIR_P) $(BINPATH) $(OBJPATH)
