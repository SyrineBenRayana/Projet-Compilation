D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*

%{
#include <stdio.h>
#include "y.tab.h"


/* Ne gère pas les commentaires. A rajouter */
/* Supprimer les lignes dont vous n'avez pas besoin. */

%}

%%
"auto"                  { /* A completer */ }#
"break"                 { /* A completer */ }#
"case"                  { /* A completer */ }#
"char"                  { /* A completer */ }#
"const"                 { /* A completer */ }#
"continue"              { /* A completer */ }#
"default"               { /* A completer */ }#
"do"                    { /* A completer */ }#
"double"                { /* A completer */ }#
"else"                  { return ELSE }
"enum"                  { /* A completer */ }#
"extern"                { return EXTERN }
"float"                 { /* A completer */ }#
"for"                   { return FOR }#
"goto"                  { return GOTO }
"if"                    { return IF }
"int"                   { return INT }
"long"                  { /* A completer */ }#
"register"              { /* A completer */ }#
"return"                { return RETURN }
"short"                 { /* A completer */ }#
"signed"                { /* A completer */ }#
"sizeof"                { return SIZEOF }
"static"                { /* A completer */ }#
"struct"                { return STRUCT }
"switch"                { /* A completer */ }#
"typedef"               { /* A completer */ }
"union"                 { /* A completer */ }
"unsigned"              { /* A completer */ }#
"void"                  { return VOID }
"volatile"              { /* A completer */ }#
"while"                 { return WHILE }

{L}({L}|{D})*           { return IDENTIFIER }

0[xX]{H}+{IS}?          { /* A completer */ }
0{D}+{IS}?              { /* A completer */ }
{D}+{IS}?               { /* A completer */ }
L?'(\\.|[^\\'])+'       { /* A completer */ }

{D}+{E}{FS}?            { /* A completer */ }
{D}*"."{D}+({E})?{FS}?  { /* A completer */ }
{D}+"."{D}*({E})?{FS}?  { /* A completer */ }

L?\"(\\.|[^\\"])*\"     { /* A completer */ }#

"..."                   { /* A completer */ }#
">>="                   { /* A completer */ }#
"<<="                   { /* A completer */ }#
"+="                    { /* A completer */ }#
"-="                    { /* A completer */ }#
"*="                    { /* A completer */ }#
"/="                    { /* A completer */ }#
"%="                    { /* A completer */ }#
"&="                    { /* A completer */ }#
"^="                    { /* A completer */ }#
"|="                    { /* A completer */ }#
">>"                    { /* A completer */ }#
"<<"                    { /* A completer */ }#
"++"                    { /* A completer */ }#
"--"                    { /* A completer */ }#
"->"                    { return PTR_OP }
"&&"                    { return AND_OP }
"||"                    { return OR_OP }
"<="                    { return LE_OP }
">="                    { return GE_OP }
"=="                    { return EQ_OP }
"!="                    { return NE_OP }

[ \t\v\n\f]             ;
.                       { return yytext[0]; }
%%