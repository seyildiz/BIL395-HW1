# BIL395-HW1 Su Eda YILDIZ

This github repository includes 2024-2025 Spring BIL395-Programming Language course's first homework. In this homework, I implemented simple calculator that includes variables, assigments, simple arithmetics and simple error handling with lex and yacc. In repository, you can find calculator.l, calculator.y and test_cases.txt that I use for checking my calculator's accuracy.

# Implementing Lex File

Lex files implemented with given. I use regular expression to describe NUMBER and IDENTIFIER. IDENTIFIER and ASSIGN was not specified but the problem part in homework had variables and assignments so I added. Also for bonus I added EXPONENT. I ignored whitespaces and tabs.

# Implementing Yacc File

Yacc file implemented with given rules. I added associativity and precedence rules for tokens. 

For variables I described a struct that has name and value. Then I wrote 2 fuctions that sets and gets the variables. `get_variable_val` returns the value of inputted variable if variable is found in variables array else return the Undefined Variable error. `set_variable_val` looks variables array for given name if found in array it sets the value for found index else creates a new variable and adds it to variables array.

Also for error handling I wrote yyerror function. This function takes a string(char pointer) and prints the given error string. However, I do not want to end my program as long as the user presses Ctrl+D(alternatively Ctrl+C). Thus, the program continues after error occures. Mentioned errors includes Divison By Zero, Invalid Expression, Variable Limit Exceeded and Undefined Variable.

Lastly, after added FLOAT, all results will be outputted as float so, for printing the result I wrote `print_result` function. It checks the result and int casted result is equal and prints accordingly. 

# Compiling and Running

I am using Windows thus, I compiled my files via wsl terminal. Open wsl terminal, cd to directory that calculator files in. Then command these lines:

flex calculator.l

bison -d calculator.y

gcc calculator.tab.c lex.yy.c -o calculator -lm # (I used math.h for pow function, -lm flag is needed to include math.)

Above three will compile code and makes output program 'calculator'. Then, program can be runned with `./calculator` command. Below you can see all steps and some test cases results.

<img width="495" alt="Screenshot 2025-03-24 175316" src="https://github.com/user-attachments/assets/6e036653-7ecb-4109-b7f2-9eb1b45a4f23" />
