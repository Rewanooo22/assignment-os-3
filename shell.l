%{
#include "shell.tab.h"
#include <string.h>
%}

%%
[ \t]           ; 
"\n"            { return NEWLINE; }
"|"             { return PIPE; }
"<"             { return REDIRECT_IN; }
">"             { return REDIRECT_OUT; }
">>"            { return REDIRECT_APPEND; }
[a-zA-Z0-9._/-]+ { yylval.string = strdup(yytext); return WORD; }
.               ; 
%%

int yywrap() { return 1; }
