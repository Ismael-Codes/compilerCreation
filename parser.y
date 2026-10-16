%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);

extern int yylineno;
int errores = 0;
%}

%token TIPO VARIABLE
%token ENTERO DECIMAL CARACTER BOOLEANO
%token SUMA RESTA MULT DIV
%token IGUAL MENOR MAYOR
%token ASIGNACION PUNTOYCOMA

%left IGUAL
%left MENOR MAYOR
%left SUMA RESTA
%left MULT DIV

%%

programa
        : programa sentencia
        | sentencia
        ;

sentencia
        : TIPO VARIABLE ASIGNACION expresion PUNTOYCOMA
              { printf("Linea %d: declaracion correcta\n", yylineno); }
        | VARIABLE ASIGNACION expresion PUNTOYCOMA
              { printf("Linea %d: asignacion correcta\n", yylineno); }
        | error PUNTOYCOMA
              { yyerrok; }
        ;

expresion
        : expresion SUMA expresion
        | expresion RESTA expresion
        | expresion MULT expresion
        | expresion DIV expresion
        | expresion IGUAL expresion
        | expresion MENOR expresion
        | expresion MAYOR expresion
        | valor
        ;

valor
        : ENTERO
        | DECIMAL
        | CARACTER
        | BOOLEANO
        | VARIABLE
        ;

%%

void yyerror(const char *s)
{
    errores++;
    printf("Error sintactico en linea %d: %s\n", yylineno, s);
}

int main(void)
{
    printf("Analizando...\n");

    yyparse();

    if (errores == 0)
        printf("Sintaxis correcta\n");
    else
        printf("Se encontraron %d errores\n", errores);

    return 0;
}
