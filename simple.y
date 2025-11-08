/*
 * CS250
 *
 * simple.y: simple parser for the simple "C" language
 * 
 * (C) Copyright Gustavo Rodriguez-Rivera grr@purdue.edu
 *
 * IMPORTANT: Do not post in Github or other public repository
 */

%token	<string_val> WORD

%token 	NOTOKEN LPARENT RPARENT LBRACE RBRACE LCURLY RCURLY COMA SEMICOLON EQUAL STRING_CONST LONG LONGSTAR VOID CHARSTAR CHARSTARSTAR INTEGER_CONST AMPERSAND OROR ANDAND EQUALEQUAL NOTEQUAL LESS GREAT LESSEQUAL GREATEQUAL PLUS MINUS TIMES DIVIDE PERCENT IF ELSE WHILE DO FOR CONTINUE BREAK RETURN

%union	{
		char   *string_val;
		int nargs;
		int my_nlabel;
	}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
int yyerror(const char * s);

extern int line_number;
const char * input_file;
char * asm_file;
FILE * fasm;

#define MAX_ARGS 5
int nargs;
char * args_table[MAX_ARGS];

#define MAX_GLOBALS 100
int nglobals = 0;
char * global_vars_table[MAX_GLOBALS];
int global_vars_type[MAX_GLOBALS];

#define MAX_LOCALS 32
#define MAX_LOCALS_SPACE (8 * MAX_LOCALS)
int nlocals = 0;
char * local_vars_table[MAX_LOCALS];
int local_vars_type[MAX_LOCALS];

#define MAX_STRINGS 100
int nstrings = 0;
char * string_table[MAX_STRINGS];

char *byteRegStk[] = {"bl", "r10b", "r13b", "r14b", "r15b"};
char *regStk[]={ "rbx", "r10", "r13", "r14", "r15"};
char nregStk = sizeof(regStk)/sizeof(char*);


char *regArgs[]={ "rdi", "rsi", "rdx", "rcx", "r8", "r9"};
char nregArgs = sizeof(regArgs)/sizeof(char*);

#define MAX_LOOPS 20
int nLoops = 0;
int loopStk[MAX_LOOPS];

int top = 0;

int nargs = 0;

int nlabel = 0;

int new_var_type;

%}

%%

goal:	program
	;

program :
	function_or_var_list;

function_or_var_list:
	function_or_var_list function
	| function_or_var_list global_var
	| /*empty */
	;

function:
	var_type WORD
	{
		fprintf(fasm, "\t.text\n");
		fprintf(fasm, ".globl %s\n", $2);
		fprintf(fasm, "%s:\n", $2);

		fprintf(fasm, "\t# Save Frame pointer\n");
		fprintf(fasm, "\tpushq %%rbp\n");
		fprintf(fasm, "\tmovq %%rsp,%%rbp\n");

		fprintf(fasm, "\tsubq $%d, %%rsp\n", MAX_LOCALS_SPACE);

		fprintf(fasm, "# Save registers. \n");
		fprintf(fasm, "# Push one extra to align stack to 16bytes\n");
        fprintf(fasm, "\tpushq %%rbx\n");
		fprintf(fasm, "\tpushq %%rbx\n");
		fprintf(fasm, "\tpushq %%r10\n");
		fprintf(fasm, "\tpushq %%r13\n");
		fprintf(fasm, "\tpushq %%r14\n");
		fprintf(fasm, "\tpushq %%r15\n\n");

		nlocals = 0;
		nargs = 0;
	}
	LPARENT arguments RPARENT compound_statement
	{
		fprintf(fasm, "# Restore registers\n");
		fprintf(fasm, "\tpopq %%r15\n");
		fprintf(fasm, "\tpopq %%r14\n");
		fprintf(fasm, "\tpopq %%r13\n");
		fprintf(fasm, "\tpopq %%r10\n");
		fprintf(fasm, "\tpopq %%rbx\n");
		fprintf(fasm, "\tpopq %%rbx\n");

		fprintf(fasm, "\taddq $%d, %%rsp\n", MAX_LOCALS_SPACE);

		fprintf(fasm, "\tleave\n");
		fprintf(fasm, "\tret\n");
	}
	;

arg_list:
	arg
	| arg_list COMA arg
	;

arguments:
	arg_list
	| /*empty*/
	;

arg: var_type WORD {
	char * id = $2;
	local_vars_table[nlocals] = id;
	local_vars_type[nlocals] = new_var_type;
	fprintf(fasm, "\n\t# moving argument %d to local var\n", nargs);
	fprintf(fasm, "\tmovq %%%s, -%d(%%rbp)\n", regArgs[nargs], 8*(nlocals + 1));
	nlocals++;
	nargs++;
};

global_var:
	var_type global_var_list SEMICOLON;

global_var_list:
	WORD {
		fprintf(fasm, "\t.data\n");
		fprintf(fasm, "\t.comm %s,8\n", $1);
		global_vars_table[nglobals] = $1;
		global_vars_type[nglobals] = new_var_type;
		nglobals++;
	}
	| global_var_list COMA WORD {
		fprintf(fasm, "\t.comm %s,8\n", $3);
		global_vars_table[nglobals] = $3;
		global_vars_type[nglobals] = new_var_type;
		nglobals++;
	}
	;

var_type:
	CHARSTAR {
		new_var_type = 0;
	}
	| CHARSTARSTAR {
		new_var_type = 1;
	}
	| LONG  {
		new_var_type = 2;
	}
	| LONGSTAR {
		new_var_type = 3;
	}
	| VOID {
		new_var_type = 4;
	};

assignment:
	WORD EQUAL expression {
	 	int pos = -1;
		char * id = $1;
		for (int i = 0; i < nlocals; i++) {
			if (strcmp(local_vars_table[i], id) == 0) {
				pos = i;
				break;
			}
		}
		if (pos == -1) {
			fprintf(fasm, "\n\t# assigning to global var\n");
			fprintf(fasm, "\tmovq %%rbx, %s\n", $1);
		}
		else {		
			fprintf(fasm, "\n\t# assigning to local var\n");
			fprintf(fasm, "\tmovq %%rbx, -%d(%%rbp)\n", 8*(pos + 1));
		}
		top = 0;
	}
	| WORD LBRACE expression RBRACE {
	 	int pos = -1;
		char * id = $1;
		for (int i = 0; i < nlocals; i++) {
			if (strcmp(local_vars_table[i], id) == 0) {
				pos = i;
				break;
			}
		}

		int type;
		if (pos == -1) {
			for (int i = 0; i < nglobals; i++) {
				if (strcmp(global_vars_table[i], id) == 0) {
					type = global_vars_type[i];
					break;
				}
			}
		}
		else {
			type = local_vars_type[pos];
		}

		if (type == 0) {
			fprintf(fasm, "\n\t# setting offset for char array\n");
			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top - 1]);
		}
		else {
			fprintf(fasm, "\n\t# setting offset for non-char array\n");
			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top - 1]);
		}

		if (pos == -1) {
			fprintf(fasm, "\n\t# assigning global var array\n");
			fprintf(fasm, "\tmovq %s, %%%s\n", id, regStk[top]);
		}
		else {
			fprintf(fasm, "\n\t# assignign local var array\n");
			fprintf(fasm, "\tmovq -%d(%%rbp), %%%s\n", 8*(pos + 1), regStk[top]);
		}
		top++;
		fprintf(fasm, "\taddq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		top--;
	}
	EQUAL expression {
		fprintf(fasm, "\tmovq %%%s, (%%%s)\n", regStk[top - 1], regStk[top - 2]);
		top = top - 2;
	}
	;

call :
	WORD LPARENT  call_arguments RPARENT {
		char * funcName = $<string_val>1;
		int nargs = $<nargs>3;
		int i;
		fprintf(fasm,"     # func=%s nargs=%d\n", funcName, nargs);
		fprintf(fasm,"     # Move values from reg stack to reg args\n");
		for (i=nargs-1; i>=0; i--) {
			top--;
			fprintf(fasm, "\tmovq %%%s, %%%s\n",
			regStk[top], regArgs[i]);
		}
		if (!strcmp(funcName, "printf")) {
			// printf has a variable number of arguments
			// and it need the following
			fprintf(fasm, "\tmovl $0, %%eax\n");
		}
		fprintf(fasm, "\tcall %s\n", funcName);
		fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top]);
		top++;
	}
	;

call_arg_list:
	expression {
		$<nargs>$=1;
	}
	| call_arg_list COMA expression {
		$<nargs>$++;
	}
	;

call_arguments:
	call_arg_list { $<nargs>$=$<nargs>1; }
	| /*empty*/ { $<nargs>$=0;}
	;

expression :
	logical_or_expr
	;

logical_or_expr:
	logical_and_expr
	| logical_or_expr OROR logical_and_expr {
		fprintf(fasm, "\n\t# ||\n");
		fprintf(fasm, "\torq %%%s, %%%s\n", regStk[top -1], regStk[top - 2]);
		top--;
	}
	;

logical_and_expr:
	equality_expr
	| logical_and_expr ANDAND equality_expr {
		fprintf(fasm, "\n\t# &&\n");
		fprintf(fasm, "\tandq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		top--;
	}
	;

equality_expr:
	relational_expr
	| equality_expr EQUALEQUAL relational_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# ==\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjne not_equal_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp equality_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "not_equal_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "equality_end_%d:\n", $<my_nlabel>1);
		top--;
	}
	| equality_expr NOTEQUAL relational_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# !=\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjne not_equal_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp equality_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "not_equal_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "equality_end_%d:\n", $<my_nlabel>1);
		top--;
	}
	;

relational_expr:
	additive_expr
	| relational_expr LESS additive_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# <\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjl less_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp relation_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "less_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "relation_end_%d:\n", $<my_nlabel>1);
		top--;
	}
	| relational_expr GREAT additive_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# >\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjg greater_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp relation_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "greater_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "relation_end_%d:\n", $<my_nlabel>1);
		top--;
	}
	| relational_expr LESSEQUAL additive_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# <=\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjle less_equal_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp relation_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "less_equal_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "relation_end_%d:\n", $<my_nlabel>1);
		top--;
	} 
	| relational_expr GREATEQUAL additive_expr {
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "\n\t# >=\n");
		fprintf(fasm, "\tcmpq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		fprintf(fasm, "\tjge greater_equal_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "\tjmp relation_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "greater_equal_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tmovq $1, %%%s\n", regStk[top - 2]);
		fprintf(fasm, "relation_end_%d:\n", $<my_nlabel>1);
		top--;
	}
	;

additive_expr:
	multiplicative_expr
	| additive_expr PLUS multiplicative_expr {
		fprintf(fasm,"\n\t# +\n");
		if (top<nregStk) {
			fprintf(fasm, "\taddq %%%s,%%%s\n", regStk[top-1], regStk[top-2]);
			top--;
		}
	}
	| additive_expr MINUS multiplicative_expr {
		fprintf(fasm, "\n\t# -\n");
		if (top < nregStk) {
			fprintf(fasm, "\tsubq %%%s,%%%s\n", regStk[top-1], regStk[top-2]);
			top--;
		}
	}
	;

multiplicative_expr:
	primary_expr
	| multiplicative_expr TIMES primary_expr {
		fprintf(fasm,"\n\t# *\n");
		if (top<nregStk) {
			fprintf(fasm, "\timulq %%%s,%%%s\n", regStk[top-1], regStk[top-2]);
			top--;
		}
	}
	| multiplicative_expr DIVIDE primary_expr {
		fprintf(fasm,"\n\t# /\n");
		if (top<nregStk) {
			fprintf(fasm, "\tmovq $0, %%rdx\n");
			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top - 2]);
			fprintf(fasm, "\tidivq %%%s\n", regStk[top - 1]);
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top - 2]);
			top--;
		}		
	}
	| multiplicative_expr PERCENT primary_expr {
		fprintf(fasm,"\n\t# %%\n");
		if (top<nregStk) {
			fprintf(fasm, "\tmovq $0, %%rdx\n");
			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top - 2]);
			fprintf(fasm, "\tidivq %%%s\n", regStk[top - 1]);
			fprintf(fasm, "\tmovq %%rdx, %%%s\n", regStk[top - 2]);
			top--;
		}		
	}
	;

primary_expr:
	STRING_CONST {
		// Add string to string table.
		// String table will be produced later
		string_table[nstrings]=$<string_val>1;
		fprintf(fasm, "\t#top=%d\n", top);
		fprintf(fasm, "\n\t# push string %s top=%d\n",
			$<string_val>1, top);
		if (top<nregStk) {
			fprintf(fasm, "\tmovq $string%d, %%%s\n", nstrings, regStk[top]);
			//fprintf(fasm, "\tmovq $%s,%%%s\n", //$<string_val>1, regStk[top]);
			top++;
		}
		nstrings++;
	}
	| call
	| WORD {
		int pos = -1;
		char * id = $1;
		for (int i = 0; i < nlocals; i++) {
			if (strcmp(local_vars_table[i], id) == 0) {
				pos = i;
				break;
			}
		}
		if (pos == -1) {
			fprintf(fasm, "\n\t# push global var\n");
			fprintf(fasm, "\tmovq %s, %%%s\n", id, regStk[top]);
		}
		else {
			fprintf(fasm, "\n\t# push local var\n");
			fprintf(fasm, "\tmovq -%d(%%rbp), %%%s\n", 8*(pos + 1), regStk[top]);
		}
		top++;
	}
	| WORD LBRACE expression RBRACE {
		int pos = -1;
		char * id = $1;
		for (int i = 0; i < nlocals; i++) {
			if (strcmp(local_vars_table[i], id) == 0) {
				pos = i;
				break;
			}
		}

		int type;
		if (pos == -1) {
			for (int i = 0; i < nglobals; i++) {
				if (strcmp(global_vars_table[i], id) == 0) {
					type = global_vars_type[i];
					break;
				}
			}
		}
		else {
			type = local_vars_type[pos];
		}

		if (type == 0) {
			fprintf(fasm, "\n\t# setting offset for char array\n");
			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top - 1]);
		}
		else {
			fprintf(fasm, "\n\t# setting offset for non-char array\n");
			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top - 1]);
		}
		if (pos == -1) {
			fprintf(fasm, "\n\t# push global var array\n");
			fprintf(fasm, "\tmovq %s, %%%s\n", id, regStk[top]);
		}
		else {
			fprintf(fasm, "\n\t# push local var array\n");
			fprintf(fasm, "\tmovq -%d(%%rbp), %%%s\n", 8*(pos + 1), regStk[top]);
		}
		top++;
		fprintf(fasm, "\taddq %%%s, %%%s\n", regStk[top - 1], regStk[top - 2]);
		top--;
		fprintf(fasm, "\tmovq (%%%s), %%%s\n", regStk[top - 1], regStk[top - 1]);

		if (type == 0) {
			fprintf(fasm, "\tmovb %%%s, %%%s\n", byteRegStk[top - 1], byteRegStk[top]);
			fprintf(fasm, "\tmovq $0, %%%s\n", regStk[top - 1]);
			fprintf(fasm, "\tmovb %%%s, %%%s\n", byteRegStk[top], byteRegStk[top - 1]);
		}
	}
	| AMPERSAND WORD {
		int pos = -1;
		char * id = $2;
		for (int i = 0; i < nlocals; i++) {
			if (strcmp(local_vars_table[i], id) == 0) {
				pos = i;
				break;
			}
		}
		fprintf(fasm, "\n\t# memory reference of\n");
		if (pos == -1) {
			fprintf(fasm, "\tleaq %s, %%%s\n", id, regStk[top]);
		} else {
			fprintf(fasm, "\tleaq -%d(%%rbp), %%%s\n", 8*(pos + 1), regStk[top]);
		}
		top++;
	}
	| INTEGER_CONST {
		fprintf(fasm, "\n\t# push %s\n", $<string_val>1);
		if (top<nregStk) {
			fprintf(fasm, "\tmovq $%s,%%%s\n", $<string_val>1, regStk[top]);
			top++;
		}
		else {
			fprintf(stderr, "Line %d: Register overflow\n", line_number);
			exit(1);
		}
	}
	| LPARENT expression RPARENT
	;

compound_statement:
	LCURLY statement_list RCURLY
	;

statement_list:
	statement_list statement
	| /*empty*/
	;

local_var:
	var_type local_var_list SEMICOLON;

local_var_list:
	WORD {
		local_vars_table[nlocals] = $<string_val>1;
		local_vars_type[nlocals] = new_var_type;
		nlocals++;
	}
	| local_var_list COMA WORD {
		local_vars_table[nlocals] = $<string_val>3;
		local_vars_type[nlocals] = new_var_type;
		nlocals++;
	}
	;

statement:
	assignment SEMICOLON
	| call SEMICOLON { top= 0; /* Reset register stack */ }
	| local_var
	| compound_statement
	| IF LPARENT expression RPARENT {
		// act 1
		$<my_nlabel>1 = nlabel;
		nlabel++;
		fprintf(fasm, "if_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje if_end_%d\n", $<my_nlabel>1);
		top--;
	}
	statement {
		// act 2
		fprintf(fasm, "\tjmp if_end_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "if_end_%d:\n", $<my_nlabel>1);
	}
	else_optional {
		// act 3
		fprintf(fasm, "if_end_end_%d:\n",  $<my_nlabel>1);
	}
	| WHILE LPARENT {
		// act1
		$<my_nlabel>1 = nlabel;
		loopStk[nLoops] = nlabel;
		nLoops++;
		nlabel++;
		fprintf(fasm, "loop_start_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "loop_continue_%d:\n", $<my_nlabel>1);
	}
	expression RPARENT {
		// act2
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje loop_end_%d\n", $<my_nlabel>1);
		top--;
	}
	statement {
		// act3
		fprintf(fasm, "\tjmp loop_start_%d\n", $<my_nlabel>1);
		fprintf(fasm, "loop_end_%d:\n", $<my_nlabel>1);
		nLoops--;
	}
	| DO {
		// act 1
		$<my_nlabel>1 = nlabel;
		loopStk[nLoops] = nlabel;
		nLoops++;
		nlabel++;
		fprintf(fasm, "loop_start_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "loop_continue_%d:\n", $<my_nlabel>1);
	}
	statement WHILE LPARENT expression {
		// act 2
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tjne loop_start_%d\n", $<my_nlabel>1);
		top--;
	}
	RPARENT SEMICOLON {
		// act 3
		fprintf(fasm, "loop_end_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "loop_assignment_%d:\n", $<my_nlabel>1);
		nLoops--;
	}
	| FOR LPARENT assignment SEMICOLON {
		// act 1
		$<my_nlabel>1 = nlabel;
		loopStk[nLoops] = nlabel;
		nLoops++;
		nlabel++;
		fprintf(fasm, "loop_start_%d:\n", $<my_nlabel>1);
	}
	expression {
		// act 2
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje loop_end_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\tjne loop_statement_start_%d\n", $<my_nlabel>1);
		top--;
	}
	SEMICOLON {
		// act 3
		fprintf(fasm, "loop_assignment_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "loop_continue_%d:\n", $<my_nlabel>1);
	}
	assignment {
		// act 4
		fprintf(fasm, "\tjmp loop_start_%d\n", $<my_nlabel>1);
	}
	RPARENT {
		// act 5
		fprintf(fasm, "loop_statement_start_%d:\n", $<my_nlabel>1);
	}
	statement {
		// act 6
		fprintf(fasm, "\tjmp loop_assignment_%d\n", $<my_nlabel>1);
		fprintf(fasm, "loop_end_%d:\n", $<my_nlabel>1);
		nLoops--;
	}
	| jump_statement
	;

else_optional:
	ELSE  statement
	| /* empty */
	;

jump_statement:
	CONTINUE SEMICOLON {
		$<my_nlabel>1 = nlabel - 1;
		fprintf(fasm, "\tjmp loop_continue_%d\n", $<my_nlabel>1);
	}
	| BREAK SEMICOLON {
		$<my_nlabel>1 = nlabel - 1;
		fprintf(fasm, "\n\tjmp loop_end_%d\n", $<my_nlabel>1);
	}
	| RETURN expression SEMICOLON {
		fprintf(fasm, "\tmovq %%rbx, %%rax\n");
		top = 0;
		fprintf(fasm, "# Restore registers\n");
		fprintf(fasm, "\tpopq %%r15\n");
		fprintf(fasm, "\tpopq %%r14\n");
		fprintf(fasm, "\tpopq %%r13\n");
		fprintf(fasm, "\tpopq %%r10\n");
		fprintf(fasm, "\tpopq %%rbx\n");
		fprintf(fasm, "\tpopq %%rbx\n");

		fprintf(fasm, "\taddq $%d, %%rsp\n", MAX_LOCALS_SPACE);

		fprintf(fasm, "\tleave\n");
		fprintf(fasm, "\tret\n");
	}
	;

%%

void yyset_in (FILE *  in_str );

int yyerror(const char * s) {
	fprintf(stderr,"%s:%d: %s\n", input_file, line_number, s);
}

int main(int argc, char **argv) {
	printf("-------------WARNING: You need to implement global and local vars ------\n");
	printf("------------- or you may get problems with top------\n");

	// Make sure there are enough arguments
	if (argc <2) {
		fprintf(stderr, "Usage: simple file\n");
		exit(1);
	}

	// Get file name
	input_file = strdup(argv[1]);

	int len = strlen(input_file);
	if (len < 2 || input_file[len-2]!='.' || input_file[len-1]!='c') {
		fprintf(stderr, "Error: file extension is not .c\n");
		exit(1);
	}

	// Get assembly file name
	asm_file = strdup(input_file);
	asm_file[len-1]='s';

	// Open file to compile
	FILE * f = fopen(input_file, "r");
	if (f==NULL) {
		fprintf(stderr, "Cannot open file %s\n", input_file);
		perror("fopen");
		exit(1);
	}

	// Create assembly file
	fasm = fopen(asm_file, "w");
	if (fasm==NULL) {
		fprintf(stderr, "Cannot open file %s\n", asm_file);
		perror("fopen");
		exit(1);
	}

	// Uncomment for debugging
	//fasm = stderr;

	// Create compilation file
	//
	yyset_in(f);
	yyparse();

	// Generate string table
	int i;
	for (i = 0; i<nstrings; i++) {
		fprintf(fasm, "string%d:\n", i);
		fprintf(fasm, "\t.string %s\n\n", string_table[i]);
	}

	fclose(f);
	fclose(fasm);

	return 0;
}
