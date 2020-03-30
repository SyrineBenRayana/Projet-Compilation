%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NB

%%
S:
	E {printf("chaîne acceptée: %d", $1);};

E:	E '+' T { $$ = $1 + $3 ; }
	| T { $$ = $1 ; } ;

T: 	T '*' F { $$ = $1 * $3 ; }
	| F { $$ = $1 ; } ;

F: 	'(' E ')' { $$ = $2 ; }
	| NB { $$ = $1 ; } ;
%%

int yyerror( char *s ) {
fprintf( stderr, "Err ls %s\n", s );
exit(1);
}
int main() {
while (1) yyparse();
}

