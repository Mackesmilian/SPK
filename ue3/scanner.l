/* Lexical analysis (Scanner) specification */
/* MSE-3 BB Sprachkonzepte WS 2023 H. Moritsch */

%{

enum { OTHER=0, PLUS, MULT, MINUS, DIV, ASSIGN, ID, TYPE, DIMENSION, SIZE, VALUE, EOL };
//     0        1     2     3      4      9     10   11      12       13  

%}

/* single input file */
%option noyywrap 

/* yytext: the token as string */

%%


"+"         return PLUS; 
"*"         return MULT;
"-"         return MINUS;
"/"         return DIV;
" set "       return ASSIGN;

\w+\d*      return ID;
(float|int)(?(?=>0) ?| +)(>0)? return TYPE;
\\[(1|2|3)\\]   return DIMENSION;
\\[[1-9]+[0-9]*\\] return SIZE;
\\-?[0-9,?]+ return VALUE;

^[ \t]*\n   /* ignore empty lines */

[ \t]       /* ignore space and tab within line */

\n          return EOL;         /* end of line */

.           return OTHER;       /* the rest is (character wise) recognized as OTHER token  */

%%

