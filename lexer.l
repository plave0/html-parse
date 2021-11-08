/* Lexer - tokenization*/

%option noyywrap

%{

    #include <stdio.h>
    #include <stdlib.h>

    #define START_TAG 1
    #define END_TAG 2

%}

START_TAG_RE "<"[^/].*?">"
END_TAG_RE "</".*?">"

%%

{START_TAG_RE}     { return START_TAG; }
{END_TAG_RE}       { return END_TAG; }
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
    while(token = yylex()) {
        
        switch(token) {

            case START_TAG:
                printf("Otvoren tag: %s\n", yytext);
                break;
            case END_TAG:
                printf("Zatvoren tag: %s\n", yytext);
        }
    }

    fclose(yyin);

    exit(EXIT_SUCCESS);
}