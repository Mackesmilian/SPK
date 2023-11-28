/* Arithmetic expressions interpreter
 * MSE-3 BB Sprachkonzepte WS 2022
 * H.Moritsch
 */
 
%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex(void); 
extern char *yytext;    
extern int yylineno;    
double mem[26] = {0};
double res = 0;

int yyerror(char *s);  
%}

%union {
        int intValue;
        double realValue;
}

%token PLUS_OP MINUS_OP MULT_OP DIV_OP 
%token PAR_LEFT PAR_RIGHT
%token EOL
%token OTHER
%token <realValue> FPNUM
%token <intValue> MEM // new token for memory variable
%token <intValue> ASSIGN // new token for assignment operator

%start lines
%type <realValue> sigfactor term factor line lines 
%%

lines   : lines line
        |                           
        ;

line    : ASSIGN MEM EOL            { mem[$2] = res; printf("%.6f ---- %d ---- %c\n", mem[$2], $2, $2 + 'a');} // assignment to memory
        | term EOL                  { printf("%.6f\n", $1); res = $1;} // store result in memory
        | MEM EOL                   { $$ = mem[$1]; printf("%.6f ---- %d ---- %c\n", mem[$1], $1, $1 + 'a'); } // use memory value
        ;

term    : term MULT_OP factor       { $$ = $1 * $3; }   
        | term DIV_OP factor        { $$ = $1 / $3; }   
        | term PLUS_OP term         { $$ = $1 + $3; }   
        | term MINUS_OP term        { $$ = $1 - $3; }   
        | sigfactor                 { $$ = $1; }        
        ;

sigfactor : factor                  { $$ =  $1; }       
        | PLUS_OP factor            { $$ =  $2; }       
        | MINUS_OP factor           { $$ = -$2; }       

factor  : FPNUM                     { $$ = $1; }        
        | PAR_LEFT term PAR_RIGHT   { $$ = $2; }
        | MEM                       { $$ = mem[$1]; } // use memory value
        ;


%%

int main(int argc, char **argv) {
    if (yyparse() == 0) {   
        printf("ok\n");
    }
}

int yyerror(char *s) {
    printf("%s in line %d at token \"%s\"\n", s, yylineno, yytext);
}