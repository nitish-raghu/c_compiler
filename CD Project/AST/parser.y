%{
	#include "abstract_syntax_tree.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char* s); 											 
	int yylex(); 												
	extern int yylineno; 											%}
// union to allow nodes to have return different datatypes
%union																
{
	char* text;
	expression_node* exp_node;
}
%token <text> T_ID T_NUM
%type <exp_node> E T F ASSGN

/* specify start symbol */
%start START
%%
START : ASSGN	{printf("Valid syntax\n"); YYACCEPT;}
	;
ASSGN : T_ID '=' E	
	;
E : E '+' T 	
   | E '-' T 	
   | T 		
   ;
T : T '*' F 	
   | T '/' F 	
   | F 		
   ;
F : '(' E ')' 
	| T_ID 	
	| T_NUM 
	;
%%


/* error handling function */
void yyerror(char* s)
{
	printf("Error :%s at %d \n",s,yylineno);
}


/* main function - calls the yyparse() function which will in turn drive yylex() as well */
int main(int argc, char* argv[])
{
	yyparse();
	return 0;
}