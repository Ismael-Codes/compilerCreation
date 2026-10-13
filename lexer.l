%{
#include <stdio.h>
%}
%option noyywrap

%%
DEFINE      { fprintf(yyout, "DEFINE "); }
PRINT       { fprintf(yyout, "PRINT "); }

[0-9]{2}[/][0-9]{2}[/][0-9]{4}   { fprintf(yyout, "FECHA "); }
["][^"]*["]                       { fprintf(yyout, "CADENA "); }
[0-9]+([.][0-9]+)?                { fprintf(yyout, "NUMERO "); }
[a-zA-Z_][a-zA-Z0-9_]*            { fprintf(yyout, "VARIABLE "); }
[+]                               { fprintf(yyout, "SUMA "); }
[*]                               { fprintf(yyout, "MULT "); }
[ \t\n]+                          { fprintf(yyout, "%s", yytext); }
.                                 { fprintf(yyout, "%s", yytext); }
%%

int main(void) {
    yyin  = fopen("programa.txt", "r");
    yyout = fopen("out.txt", "w");

    if (!yyin)  { perror("No se pudo abrir programa.txt"); return 1; }
    if (!yyout) { perror("No se pudo abrir out.txt");      return 1; }

    yylex();

    fclose(yyin);
    fclose(yyout);
    return 0;
}