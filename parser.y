%{
    #include <stdio.h>
    #include <stdlib.h>

    extern int yylex();
    void yyerror(const char *s);
    int errores = 0;
%}

%token DEFINE
%token PRINT

%token VARIABLE
%token NUMERO
%token CADENA
%token FECHA

%token SUMA
%token MULT

%left SUMA
%left MULT

%start programa

%%

programa
        : programa sentencia
        | sentencia
        ;

sentencia
        : definicion '\n'
        | impresion '\n'
        | '\n'
        | error '\n'       { yyerrok; }
        ;

definicion
        : DEFINE VARIABLE valor
        ;

impresion
        : PRINT valor
        ;

valor
        : CADENA
        | FECHA
        | expresion
        ;

expresion
        : expresion SUMA termino
        | termino
        ;

termino
        : termino MULT factor
        | factor
        ;

factor
        : NUMERO
        | VARIABLE
        ;

%%

extern int yylineno;
void yyerror(const char *s)
{
    errores++;
    printf("Error sintactico en linea %d: %s\n", yylineno, s);
}

int main()
{
    printf("Analizando...\n");

    yyparse();

    if(errores == 0)
        printf("Sintaxis correcta\n");
    else
        printf("Se encontraron %d errores\n", errores);

    return 0;
}