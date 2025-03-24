%{
#include "calculator.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

[0-9]+(\.[0-9]+)?     { yylval.fval = atof(yytext); return NUMBER; }
"**"                  { return EXPONENT; }
"^"                   { return EXPONENT; }
"+"                   { return PLUS; }
"-"                   { return MINUS; }
"*"                   { return TIMES; }
"/"                   { return DIVIDE; }
"="                   { return ASSIGN; }
"("                   { return LPAREN; }
")"                   { return RPAREN; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return IDENTIFIER; }
\n                    { return '\n'; }
[ \t\r]+              ;  // Ignore whitespace
.                     { printf("Unexpected character: %s\n", yytext); exit(1); }

%%
    
int yywrap(void) {
    return 1;
}
    