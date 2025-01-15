CC = gcc
BISON = bison
FLEX = flex

all: parser run

parser: lex.yy.c class.tab.c
	$(CC) lex.yy.c class.tab.c -o parser.exe

lex.yy.c: class.l class.tab.h
	$(FLEX) class.l

class.tab.c class.tab.h: class.y
	$(BISON) -d class.y

run:
	parser.exe

clean:
	del /Q parser.exe lex.yy.c class.tab.c class.tab.h output.txt 2>nul
