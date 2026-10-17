%{
#include <stdio.h>

int num_linea = 1; /* Contador de lineas para reportar errores */
%}

%option noyywrap

%%

/* ============================================================
  * 1. COMENTARIOS
* ============================================================ */
"//"[^\n]*          { fprintf(yyout, "COMENTARIO "); }

/* ============================================================
     * 2. PALABRAS RESERVADAS
* ============================================================ */
"Ent"               { fprintf(yyout, "TIPO "); }
"Npd"              { fprintf(yyout, "TIPO "); }
"let"             { fprintf(yyout, "TIPO "); }
"logic"            { fprintf(yyout, "TIPO "); }
"txt"             { fprintf(yyout, "TIPO "); }

"imp"           { fprintf(yyout, "MOSTRAR "); }
"defin"           { fprintf(yyout, "DEFINE "); }

"true"            { fprintf(yyout, "BOOLEANO "); }
"false"          { fprintf(yyout, "BOOLEANO "); }
%%

int main(void) {
    return 0;
}