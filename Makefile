lexer: lex.yy.c
	gcc lex.yy.c -o lexer
lex.yy.c: lexer.l
	flex lexer.l

.PHONY: clean

clean:
	rm lex.yy.c