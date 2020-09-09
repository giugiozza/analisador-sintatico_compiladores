#
# UFRGS - Compiladores B - Marcelo Johann - ERE 2020/1 - Etapa 2
#
# Makefile for single compiler call
# All source files must be included from code embedded in scanner.l
# In our case, you probably need #include "hash.c" at the beginning
# and #include "main.c" in the last part of the scanner.l
#

etapa1: lex.yy.c
	gcc -o etapa2 lex.yy.c
lex.yy.c: scanner.l
	lex scanner.l

clean:
	rm lex.yy.c etapa2
