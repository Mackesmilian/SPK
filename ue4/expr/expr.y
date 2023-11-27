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
#define YYSTYPE double  

double mem = 0; // define the memory variable
double res = 0;

int yyerror(char *s);  
%}

%token PLUS_OP MINUS_OP MULT_OP DIV_OP 
%token PAR_LEFT PAR_RIGHT
%token EOL
%token OTHER
%token FPNUM
%token MEM // new token for memory variable
%token ASSIGN // new token for assignment operator

%start lines

%%

lines   : lines line
        |                           
        ;

line    : ASSIGN term EOL           { mem = res; printf("%.6f\n", mem);} // assignment to memory
        | term EOL                  { printf("%.6f\n", $1); res = $1;} // store result in memory
        | MEM EOL                   { $$ = mem; printf("%.6f\n", mem); } // use memory value
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
        | MEM                       { $$ = mem; } // use memory value
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