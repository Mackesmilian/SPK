/* Arithmetic Expressions Scanner
 * MSE-3 BB Sprachkonzepte WS 2023
 * H. Moritsch
 */

%{
#include "expr.tab.h"
extern double mem; // declare the memory variable
%}

digit [0-9]  

%option yylineno
%option noyywrap 

%%

"+"         return PLUS_OP; 
"*"         return MULT_OP;
"-"         return MINUS_OP;
"/"         return DIV_OP;

"("         return PAR_LEFT; 
")"         return PAR_RIGHT;

{digit}+([,.]{digit}+)?     { 
                            char* colon_ptr = strchr(yytext,',');   
                            if (colon_ptr)
                                *colon_ptr = '.';
                            sscanf(yytext, "%lf", &yylval);         
                            return FPNUM;
                            } 

"="         return ASSIGN;
[a-z]       {yylval.intValue = yytext[0] - 'a'; return MEM;} // new token for memory variable

^[ \t]*\n                   /* ignore empty lines                           */
[ \t]                       /* ignore space, tab within line                */

\n          return EOL;     
.           return OTHER;   

%%