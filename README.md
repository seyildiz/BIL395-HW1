# BIL395-HW1

This github repository includes 

# Implementing Lex File


# Implementing Yacc File

# Compiling and Running

I am using Windows thus, I compiled my files via wsl terminal. Open wsl terminal, cd to directory that calculator files in. Then command these lines:

flex calculator.l
bison -d calculator.y
gcc calculator.tab.c lex.yy.c -o calculator -lm # (I used math.h for pow function, -lm flag is needed to include math.)

Above three will compile code and makes output program 'calculator'. Then, program can be runned with `./calculator` command. Below you can see all steps and some test cases results.

<img width="495" alt="Screenshot 2025-03-24 175316" src="https://github.com/user-attachments/assets/6e036653-7ecb-4109-b7f2-9eb1b45a4f23" />
