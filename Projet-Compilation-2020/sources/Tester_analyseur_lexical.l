D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*

%{
#include <stdio.h>
/*#include "y.tab.h"*/
#include <stdlib.h>

#define TOKEN_EOF 0
#define IDENTIFIER 1
#define CONSTANT 2
#define SIZEOF 3
#define PTR_OP 4
#define LE_OP 5
#define GE_OP 6
#define  EQ_OP 7
#define NE_OP 8
#define AND_OP 9
#define OR_OP 10
#define EXTERN 11
#define INT 12
#define VOID 13
#define STRUCT 14
#define IF 15
#define ELSE 16
#define WHILE 17 
#define FOR 18
#define RETURN 19
#define GOTO 20


/* Ne gère pas les commentaires. A rajouter */
/* Supprimer les lignes dont vous n'avez pas besoin. */

%}

%%
"else"                  { return ELSE ; }
"extern"                { return EXTERN ;}
"for"                   { return FOR ; }
"goto"                  { return GOTO ;}
"if"                    { return IF ;}
"int"                   { return INT ;}
"return"                { return RETURN ;}
"sizeof"                { return SIZEOF ;}
"struct"                { return STRUCT ;}
"void"                  { return VOID ;}
"while"                 { return WHILE ;}

{L}({L}|{D})*           { return IDENTIFIER ;}

"->"                    { return PTR_OP ;}
"&&"                    { return AND_OP ;}
"||"                    { return OR_OP ;}
"<="                    { return LE_OP ;}
">="                    { return GE_OP ;}
"=="                    { return EQ_OP ;}
"!="                    { return NE_OP ;}

[ \t\v\n\f]             ;
.                       { return yytext[0]; }
%%
int main(){
int token_courant;
printf("Codes des tokens retournés par yylex: ");
do {
token_courant=yylex();
printf("%d ", token_courant);
token_courant=yylex();
} while (token_courant !=TOKEN_EOF);
return(0);
}
