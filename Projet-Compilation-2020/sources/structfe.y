%token IDENTIFIER CONSTANT SIZEOF
%token PTR_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP
%token EXTERN
%token INT VOID
%token STRUCT 
%token IF ELSE WHILE FOR RETURN

%start program
%%

primary_expression	: IDENTIFIER {$$ = $1;}
        		| CONSTANT {$$ = $1;}
        		| '(' expression ')'{$$ = $2;}
        		;

postfix_expression	: primary_expression {$$ = $1;}
        		| postfix_expression '(' ')' {$$ = $1;}
        		| postfix_expression '(' argument_expression_list ')'{$$ = $1 $3;}
        		| postfix_expression '.' IDENTIFIER {$$ = $1 . $3;}
        		| postfix_expression PTR_OP IDENTIFIER {$$ = $1 $2 $3;}
        		;
argument_expression_list 	: expression {$$ = $1;}
        			| argument_expression_list ',' expression {$$ = $1 , $3;}
        			;

unary_expression	: postfix_expression {$$ = $1;}
        		| unary_operator unary_expression{$$ = $1 $2;}
        		| SIZEOF unary_expression {$$ = $1 $2;}
        		;

unary_operator 	: '&' {$$ = &;}
        	| '*' {$$ = *;}
        	| '-' {$$ = -;}
        	;

multiplicative_expression 	: unary_expression {$$ = $1;}
        			| multiplicative_expression '*' unary_expression {$$ = $1 * $3; }
        			| multiplicative_expression '/' unary_expression {$$ = $1 / $3; }
        			;

additive_expression 	: multiplicative_expression {$$ = $1;}
        		| additive_expression '+' multiplicative_expression {$$ = $1 + $3; }
        			| additive_expression '-' multiplicative_expression {$$ = $1 - $3; }
        			;

relational_expression	: additive_expression {$$ = $1;}
        		| relational_expression '<' additive_expression {$$ = $1 < $3; }
        		| relational_expression '>' additive_expression {$$ = $1 > $3; }
        		| relational_expression LE_OP additive_expression {$$ = $1 <= $3; }
        		| relational_expression GE_OP additive_expression {$$ = $1 >= $3; }
        		;

equality_expression	:relational_expression {$$ = $1;}
        		| equality_expression EQ_OP relational_expression {$$ = $1 == $3; }
        		| equality_expression NE_OP relational_expression {$$ = $1 != $3; }
        		;
logical_and_expression	: equality_expression {$$ = $1;}
        		| logical_and_expression AND_OP equality_expression {$$ = $1 && $3; }
        		;

logical_or_expression	: logical_and_expression {$$ = $1;}
        		| logical_or_expression OR_OP logical_and_expression {$$ = $1 || $3; }
        		;

expression : logical_or_expression {$$ = $1;}
        		| unary_expression '=' expression {$$ = $1 = $3; }
        		;

declaration	: declaration_specifiers declarator ';' {$$ = $1 $2 \; ;}
        	| struct_specifier ';'{$$ = $1 \; ;}
        	;

declaration_specifiers	: EXTERN type_specifier {$$ = $1 $2;}
        		| type_specifier {$$ = $1;}
        		;

type_specifier	: VOID {$$ = VOID;}
        	| INT {$$ = INT;}
        	| struct_specifier {$$ = $1;}
        	;

struct_specifier	: STRUCT IDENTIFIER '{' struct_declaration_list '}' {$$ = $1 $2 $4;}
        		| STRUCT '{' struct_declaration_list '}' {$$ = $1 $3;}
        		| STRUCT IDENTIFIER {$$ = $1 $2;}
        		;

struct_declaration_list : struct_declaration {$$ = $1;}
        		| struct_declaration_list struct_declaration {$$ = $1 $2;}
        		;

struct_declaration	: type_specifier declarator ';' {$$ = $1 $2 /; ;}
        ;

declarator	: '*' direct_declarator {$$ = * $2;}
        	| direct_declarator {$$ = $1;}
        	;

direct_declarator	: IDENTIFIER {$$ = $1;}
        		| '(' declarator ')' {$$ = $2;}
        		| direct_declarator '(' parameter_list ')' {$$ = $1 $3;}
        		| direct_declarator '(' ')' {$$ = $1;}
        		;

parameter_list	: parameter_declaration {$$ = $1;}
        	| parameter_list ',' parameter_declaration {$$ = $1 , $2;}
        	;

parameter_declaration	: declaration_specifiers declarator {$$ = $1 $2;}
        		;

statement	: compound_statement {$$ = $1;}
        	| expression_statement{$$ = $1;}
        	| selection_statement{$$ = $1;}
        	| iteration_statement{$$ = $1;}
        	| jump_statement {$$ = $1;}
        	;

compound_statement	: '{' '}'{$$;}
        		| '{' statement_list '}' {$$ = $2;}
        		| '{' declaration_list '}' {$$ = $2;}
        		| '{' declaration_list statement_list '}' {$$ = $2 $3;}
        		;

declaration_list 	: declaration {$$ = $1;}
        		| declaration_list declaration {$$ = $1 $2;}
        		;

statement_list	: statement{$$ = $1;}
        	| statement_list statement {$$ = $1 $2;}
        	;

expression_statement	: ';'{$$ = /; ;}
        		| expression ';' {$$ = $1 /; ;}
        		;

selection_statement	: IF '(' expression ')' statement{$$ = if $2 $3;}
        		| IF '(' expression ')' statement ELSE statement {$$ = if $2 else $4;}
        		;

iteration_statement	: WHILE '(' expression ')' statement {$$ = while $3 $5;}
        		| FOR '(' expression_statement expression_statement expression ')' statement {$$ = for $3 $4 $5 $7;}
        		;

jump_statement	: RETURN ';' {$$ = return /; ;}
        	| RETURN expression {$$ = return $2 /; ;}
        	;

program		: external_declaration {$$ = $1;}
        	| program external_declaration {$$ = $1 $2;}
        	;

external_declaration	: function_definition {$$ = $1;}
        		| declaration {$$ = $1;}
        		;

function_definition	: declaration_specifiers declarator compound_statement {$$ = $1 $2 $3;}
        		;

%%

