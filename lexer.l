/* Lexer - tokenization*/

%option noyywrap
%option noinput
%option nounput

%{

    #include <stdio.h>
    #include <stdlib.h>

    #define START_TAG (1)
    #define END_TAG (2)
    #define COMMENT (3)

%}

START_TAG "<"[a-zA-Z]+">"
END_TAG "</"[a-zA-Z]+">"
COMMENT "<!--"[^>]*"-->"

%%

{START_TAG}     { return START_TAG; }
{END_TAG}       { return END_TAG; }
{COMMENT}       { return COMMENT; }
.|\n                { }

%%

int main(int argc, char** argv) {

    if(argc > 1) {
        yyin = fopen(argv[1], "r");
        if(!yyin) {
            printf("File error: couldn open file\n");
            exit(EXIT_FAILURE);
        }
    }
    else {
        printf("Argument missing: input file\n");
        exit(EXIT_FAILURE);
    }

    int token;
    while((token = yylex())) {
        
        switch(token) {

            case START_TAG:
                printf("Tag open: %s\n", yytext);
                break;
            case END_TAG:
                printf("Tag close: %s\n", yytext);
                break;
            case COMMENT:
                printf("Comment: %s\n", yytext);
                break;
            default:
                printf("Token not recognized\n");
                break;
        }
    }

    fclose(yyin);

    exit(EXIT_SUCCESS);
}
