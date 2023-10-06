PROG = helloSBML
OBJS = main.o
JSON = main.o.json
CC = clang
CFLAGS = -g -Wall -I./include
CQUERYFLAGS = -MJ $(JSON)
LDFLAGS = -L./lib -Wl,--rpath -Wl,./lib -lsbml -lm -lz -lxml2 -lstdc++

.PHONY: all
all: $(PROG) compile_commands.json

.SUFFIXES: .o .c
.c.o:
	$(CC) $(CFLAGS) $(CQUERYFLAGS) -o $@ -c $<

compile_commands.json: $(JSON)
	/bin/sed -e '1s/^/[\n/' -e '$$s/,$$/\n]/' *.o.json > compile_commands.json

$(PROG): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

main-debug: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

run: $(PROG)
	./$(PROG)

.PHONY: clean
clean:
	rm -f $(PROG) $(OBJS) $(JSON)

