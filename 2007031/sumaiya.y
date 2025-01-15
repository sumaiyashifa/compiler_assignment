%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

int func_total = 0;
int temp_val = 0;
int temp_id = 0;
extern FILE* yyin;
extern FILE* yyout;
%}

%union {
    int number;
    char* string;
}

%token CLASSROOM FUNCTION THIS DISPLAY ENDCLASS CONSTRUCT
%token <number> NUM
%token <string> ID TEXT
%token EQUALS ADD POINT SEPARATOR LBRACE RBRACE SEMICOL

%%

program:
    class_def
    ;

class_def:
    CLASSROOM ID SEMICOL
    constructor
    methods
    ENDCLASS
    { 
        printf("%d functions defined\n", func_total);
    }
    ;

constructor:
    FUNCTION CONSTRUCT LBRACE THIS SEPARATOR param_list RBRACE SEMICOL
    constructor_body
    {
        func_total++;
    }
    ;

param_list:
    ID EQUALS NUM SEPARATOR ID EQUALS NUM
    {
        temp_val = $3;  
        temp_id = $7;    
    }
    ;

constructor_body:
    this_assign this_assign
    ;

this_assign:
    THIS POINT ID EQUALS ID
    ;

methods:
    method
    | methods method
    ;

method:
    FUNCTION ID LBRACE THIS RBRACE SEMICOL
    display_stmts
    {
        func_total++;
    }
    ;

display_stmts:
    display_stmt display_stmt
    ;

display_stmt:
    DISPLAY LBRACE TEXT ADD THIS POINT ID RBRACE
    {
        if (strcmp($7, "ids") == 0) {
            printf("Hello, my ID is %d\n", temp_id);
        }
        else if (strcmp($7, "value") == 0) {
            printf("Value set at %d\n", temp_val);
        }
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyin = freopen("input.txt", "r", stdin);
    yyout = freopen("output.txt", "w", stdout);
    yyparse();
    return 0;
} 