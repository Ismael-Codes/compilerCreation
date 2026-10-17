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
"Ent"                   { fprintf(yyout, "TIPO "); }
"Npd"                   { fprintf(yyout, "TIPO "); }
"let"                   { fprintf(yyout, "TIPO "); }
"logic"                 { fprintf(yyout, "TIPO "); }
"txt"                   { fprintf(yyout, "TIPO "); }

"imp"                   { fprintf(yyout, "MOSTRAR "); }
"defin"                 { fprintf(yyout, "DEFINE "); }

"true"                  { fprintf(yyout, "BOOLEANO "); }
"false"                 { fprintf(yyout, "BOOLEANO "); }

    /* ============================================================
     * 3. LITERALES (Decimales, Enteros, Caracteres, Cadenas)
    * ============================================================ */
[0-9]+"."[0-9]+     { fprintf(yyout, "DECIMAL "); }
[0-9]+              { fprintf(yyout, "ENTERO "); }
'.'                 { fprintf(yyout, "CARACTER "); }
\"[^\"]*\"          { fprintf(yyout, "CADENA "); }

    /* ============================================================
    * 4. VARIABLES
    * ============================================================ */
[a-zA-Z_][a-zA-Z0-9_]* { fprintf(yyout, "VARIABLE "); }

    /* ============================================================
     * 5. OPERADORES Y SIMBOLOS
     * ============================================================ */
"+"                 { fprintf(yyout, "SUMA "); }
"-"                 { fprintf(yyout, "RESTA "); }
"*"                 { fprintf(yyout, "MULT "); }
"/"                 { fprintf(yyout, "DIV "); }
"=="                { fprintf(yyout, "IGUAL "); }
"="                 { fprintf(yyout, "ASIGNACION "); }
"<"                 { fprintf(yyout, "MENOR "); }
">"                 { fprintf(yyout, "MAYOR "); }
";"                 { fprintf(yyout, "PUNTOYCOMA "); }

    /* ============================================================
     * 6. ESPACIOS Y SALTOS DE LINEA
     * ============================================================ */
[ \t]+              { /* Ignorar espacios y tabuladores */ }
\r?\n               { fprintf(yyout, "\n"); num_linea++; }

    /* ============================================================
     * 7. ERRORES LEXICOS
    * ============================================================ */
.                   { printf("Error lexico en linea %d: '%s' no se reconoce\n", num_linea, yytext);
                      fprintf(yyout, "ERROR "); }

%%

int main(void) {
    yyin = fopen("programa.txt", "r");
    yyout = fopen("out.txt", "w");

    if (!yyin) { perror("No se pudo abrir programa.txt"); return 1; }

    /* <--- [BUENA PRACTICA EN C]: Si "programac.txt" si abrio pero "out.txt" falla,
     * el return 1 sale del programa dejando "yyin" abierto en memoria.
     * Lo ideal es hacer: if (!yyout) { perror("..."); fclose(yyin); return 1; } */
    if (!yyout) { perror("No se pudo abrir out.txt"); return 1; }

    yylex();

    fclose(yyin);
    fclose(yyout);
    return 0;
}