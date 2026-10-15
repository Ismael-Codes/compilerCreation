%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

DEFINE                         { return DEFINE; }
PRINT                          { return PRINT; }

[0-9]{2}/[0-9]{2}/[0-9]{4}    { return FECHA; }

\"[^\"]*\"                     { return CADENA; }

[0-9]+(\.[0-9]+)?             { return NUMERO; }

[a-zA-Z_][a-zA-Z0-9_]*        { return VARIABLE; }

"+"                            { return SUMA; }

"*"                            { return MULT; }

[ \t\r]+                       ;

\n                             { return '\n'; }

.                              { return yytext[0]; }

%%