%{
#include <stdio.h>
#include "TD4.tab.h"
int yylval;
%}
const [0-9]+
%%
{const}+ {
	sscanf( yytext, "%d", &yylval );
	return NB;
}
[ \n\t] ;
\0 ;
. return yytext[0];
%%
