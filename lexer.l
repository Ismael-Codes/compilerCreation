%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option noyywrap
%option yylineno

%%

"entero"            { return TIPO; }
"decimal"           { return TIPO; }
"caracter"          { return TIPO; }
"booleano"          { return TIPO; }

"verdadero"         { return BOOLEANO; }
"falso"             { return BOOLEANO; }

[0-9]+"."[0-9]+     { return DECIMAL; }
[0-9]+              { return ENTERO; }
'.'                 { return CARACTER; }

[a-z]+              { return VARIABLE; }

"+"                 { return SUMA; }
"-"                 { return RESTA; }
"*"                 { return MULT; }
"/"                 { return DIV; }
"=="                { return IGUAL; }
"="                 { return ASIGNACION; }
"<"                 { return MENOR; }
">"                 { return MAYOR; }
";"                 { return PUNTOYCOMA; }

[ \t\r\n]           { }
.                   { printf("Error lexico en linea %d: '%s' no se reconoce\n", yylineno, yytext); }

%%
