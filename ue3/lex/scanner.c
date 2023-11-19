/* Scanner driver routine */
/* print sequence of token string and token number */
/* MSE-3 BB Sprachkonzepte WS 2023 H. Moritsch */

#include <stdio.h>
extern int yylex (void);
extern char *yytext;

char * token[] = { "OTHER", "PLUS", "MULT", "MINUS", "DIV", "ASSIGN", "ID", "NUMBER", "TYPE", "DIMENSION", "SIZE", "COMMENT", "END", "EOL"};

int main(int argc, char **argv) {
    int nr; 

    do {
        nr = yylex(); 

        printf("[%02d]\t%s\t", nr, token[nr]); 
        if (nr != 13)
            printf("%s", yytext); // yytext: the recognized token, as a string
        else
            printf("\\n"); 
        printf("\n");
 
        } while (nr != 12); // token 12 = END

    }
