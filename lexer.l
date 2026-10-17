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
"real"              { fprintf(yyout, "TIPO "); }
"letra"             { fprintf(yyout, "TIPO "); }
"logico"            { fprintf(yyout, "TIPO "); }
"texto"             { fprintf(yyout, "TIPO "); }

"mostrar"           { fprintf(yyout, "MOSTRAR "); }
"definir"           { fprintf(yyout, "DEFINE "); }

"activo"            { fprintf(yyout, "BOOLEANO "); }
"inactivo"          { fprintf(yyout, "BOOLEANO "); }
%%

int main(void) {
    return 0;
}