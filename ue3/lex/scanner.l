/* Lexical analysis (Scanner) specification */
/* MSE-3 BB Sprachkonzepte WS 2023 H. Moritsch */

%{

enum { OTHER=0, PLUS, MULT, MINUS, DIV, ASSIGN, ID, NUMBER, TYPE, DIMENSION, SIZE, COMMENT, END, EOL };
//     0        1     2     3      4        9   10    11     12   13    14

%}

/* single input file */
%option noyywrap 

/* yytext: the token as string */

%%


"+"         return PLUS; 
"*"         return MULT;
\-/" "          return MINUS;
"/"         return DIV;

"set"        return ASSIGN;
"end"       return END;
(float|int)|(float>0|int>0)       return TYPE;
\[(1|2|3)\]/\[[1-9][0-9]*\] return DIMENSION;
\[[1-9][0-9]*\] return SIZE;
#.*$ return COMMENT;

[a-z]+[a-zA-Z0-9]*      return ID;
-?[0-9]+(\.[0-9]+)?   return NUMBER;

^[ \t]*\n   /* ignore empty lines */

[ \t]       /* ignore space and tab within line */

\n          return EOL;         /* end of line */

.           return OTHER;       /* the rest is (character wise) recognized as OTHER token  */

%%

