CC = gcc
CFLAGS = -Wall -I./lib/lib1
DEPS = lib/lib1/libfile1.h
OBJ = lib/lib1/libfile1.c src/main.c

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -c -o $@ $<

go: $(OBJ)
	gcc $(CFLAGS) -o $@ $^