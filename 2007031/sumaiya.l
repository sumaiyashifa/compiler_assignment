%{
#include <stdio.h>
#include <string.h>
#include "sumaiya.tab.h"
extern YYSTYPE yylval;
%}

%%
[ \t\n]+       
"class"         { return CLASSROOM; }
"def"           { return FUNCTION; }
"self"          { return THIS; }
"print"         { return DISPLAY; }
"classend"      { return ENDCLASS; }
"__init__"      { return CONSTRUCT; }
[0-9]+          { yylval.number = atoi(yytext); return NUM; }
"="             { return EQUALS; }
"+"             { return ADD; }
"."             { return POINT; }
","             { return SEPARATOR; }
"("             { return LBRACE; }
")"             { return RBRACE; }
":"             { return SEMICOL; }
\"[^\"]*\"      { 
    yylval.string = strdup(yytext);
    return TEXT; 
}
[a-zA-Z_][a-zA-Z0-9_]*  { 
    yylval.string = strdup(yytext);
    return ID; 
}
.               ; 

%%

int yywrap() {
    return 1;
} 