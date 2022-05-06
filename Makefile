
CC=g++
TARGET=cppTest
OTHERDIR=lib

SOURCE = cppTest.cpp
SOURCE = $(OTHERDIR)/libfile3.c
#SOURCE = $(OTHERDIR)/lib1/libfile1.c

## End sources definition
INCLUDE = -I./ $(AN_INCLUDE_DIR)  
#INCLUDE = -I.$(OTHERDIR)/../inc
## end more includes

VPATH=$(OTHERDIR)
OBJ=$(join $(addsuffix ../obj/, $(dir $(SOURCE))), $(notdir $(SOURCE:.c=.o))) 

## Fix dependency destination to be ../.dep relative to the src dir
DEPENDS=$(join $(addsuffix ../.dep/, $(dir $(SOURCE))), $(notdir $(SOURCE:.c=.d)))

## Default rule executed
all: $(TARGET)
	@true

## Clean Rule
clean:
	@-rm -f $(TARGET) $(OBJ) $(DEPENDS)

## Rule for making the actual target
$(TARGET): $(OBJ)
	@echo "============="
	@echo "Linking the target $@"
	@echo "============="
	@$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
	@echo -- Link finished --

## Generic compilation rule
%.o : %.c
	@mkdir -p $(dir $@)
	@echo "============="
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

## Rules for object files from cpp files
## Object file for each file is put in obj directory
## one level up from the actual source directory.
../obj/%.o : %.c
	@mkdir -p $(dir $@)
	@echo "============="
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

# Rule for "other directory"  You will need one per "other" dir
$(OTHERDIR)/../obj/%.o : %.c
	@mkdir -p $(dir $@)
	@echo "============="
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

## Make dependancy rules
../.dep/%.d: %.c
	@mkdir -p $(dir $@)
	@echo "============="
	@echo Building dependencies file for $*.o
	@$(SHELL) -ec '$(CC) -M $(CFLAGS) $< | sed "s^$*.o^../obj/$*.o^" > $@'

## Dependency rule for "other" directory
$(OTHERDIR)/../.dep/%.d: %.c
	@mkdir -p $(dir $@)
	@echo "============="
	@echo Building dependencies file for $*.o
	@$(SHELL) -ec '$(CC) -M $(CFLAGS) $< | sed "s^$*.o^$(OTHERDIR)/../obj/$*.o^" > $@'

## Include the dependency files
-include $(DEPENDS)