PROG = helloSBML
OBJS = main.o
JSON = $(OBJS).json
CC = clang
CFLAGS = -Wall -I./include
CQUERYFLAGS = -MJ $(JSON)
LDFLAGS = -L./lib -Wl,--rpath -Wl,./lib -lsbml -lm

.PHONY: all
all: $(PROG)
	./$(PROG)

.SUFFIXES: .o .c
.c.o:
	$(CC) $(CFLAGS) $(CQUERYFLAGS) -o $@ -c $<
	/bin/sed -e '1s/^/[\n/' -e '$$s/,$$/\n]/' *.o.json > compile_commands.json

$(PROG): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

.PHONY: clean
clean:
	rm -f $(PROG) $(OBJS) $(JSON)

