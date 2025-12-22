all: minishell

minishell: lex.yy.c shell.tab.c
	gcc -o minishell lex.yy.c shell.tab.c

shell.tab.c shell.tab.h: shell.y
	bison -d shell.y

lex.yy.c: shell.l shell.tab.h
	flex shell.l

clean:
	rm -f minishell lex.yy.c shell.tab.c shell.tab.h
