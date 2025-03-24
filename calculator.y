%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
    
int yylex(void);
void yyerror(const char *s);

#define MAXVARS 10

typedef struct {
    char* name;
    double value;
} Variable;

Variable variables[MAXVARS];
int variable_count = 0;

// Function to get variable's value
double get_variable_val(const char* name) {
    for (int i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0)
            return variables[i].value;
    }

    fprintf(stderr, "Error: Undefined variable '%s'\n", name);
    return 0;
}

// Function to set variables to a value
void set_variable_val(const char* name, double value) {
    for (int i = 0; i < variable_count; i++) {
        if (strcmp(variables[i].name, name) == 0) {
            variables[i].value = value;
            return;
        }
    }
    if (variable_count < MAXVARS) {
        variables[variable_count].name = strdup(name);
        variables[variable_count].value = value;
        variable_count++;
    } else {
        fprintf(stderr, "Error: Variable limit exceeded\n");
    }
}

// Function to print values as integers if they have no fractional part
void print_result(double value) {
    // Check if the value is an integer
    if (value == (int)value) {
        printf("%d", (int)value);
    } else {
        printf("%f", value);
    }
}

%}
    
%union {
    double fval;
    char* sval;
}
    
%token <fval> NUMBER
%token <sval> IDENTIFIER
%token PLUS MINUS TIMES DIVIDE EXPONENT ASSIGN
%token LPAREN RPAREN

%left PLUS MINUS
%left TIMES DIVIDE
%right EXPONENT

    
%type <fval> expr
    
%%

input:
  | input stmt '\n'
  | input error '\n' { yyerror("Invalid expression. Please try again."); yyclearin; }
  ;
    
stmt:
    | expr { printf("Result: "); print_result($1); printf("\n"); }
    | IDENTIFIER ASSIGN expr { 
        set_variable_val($1, $3); 
        printf("%s = ", $1); 
        print_result($3); 
        printf("\n"); 
      }
;
    
expr: expr PLUS expr   { $$ = $1 + $3; }
| expr MINUS expr  { $$ = $1 - $3; }
| expr TIMES expr  { $$ = $1 * $3; }
| expr DIVIDE expr {
    if ($3 == 0) {
        yyerror("Division by zero");
            $$ = 0;
    } else {
        $$ = $1 / $3;
    }
}
| expr EXPONENT expr   { $$ = pow($1, $3); }
| LPAREN expr RPAREN { $$ = $2; }
| NUMBER             { $$ = $1; }
| IDENTIFIER           { $$ = get_variable_val($1); }
;
    
%%
    
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter expressions (press Ctrl+D to quit):\n");
    yyparse();
    return 0;
}