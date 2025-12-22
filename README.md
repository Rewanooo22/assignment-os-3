# assignment-os-3
# Minishell Project - Operating Systems (CSE233)

## 1. Project Overview
Minishell is a minimalist, Bash-like command-line interpreter implemented in C. It demonstrates core Operating System concepts including process management, environment inheritance, and I/O redirection using POSIX system calls.

## 2. Functional Features Implemented
The shell fulfills the following requirements:
* Loop & Prompt: Displays a "minishell>" prompt and reads input until exit or Ctrl-D.
* Command Execution: Executes external programs by forking child processes and using execvp.
* Built-in Commands: 
    - cd [dir]: Changes the current working directory.
    - pwd: Prints the current working directory.
    - exit: Terminates the shell cleanly.
* I/O Redirection:
    - Input redirection (<): Reads stdin from a file.
    - Output redirection (>): Truncates and writes stdout to a file.
    - Append redirection (>>): Appends stdout to a file.
* Parsing: Uses Flex (Lex) for tokenization and Bison (Yacc) for grammar parsing.

## 3. How to Build
A Makefile is provided to automate the compilation process. To build the executable:
1. Open the terminal in the project directory.
2. Type: make
3. This generates the 'minishell' executable.

## 4. How to Run
After building, run the shell using:
./minishell

## 5. Technical Requirements
* Language: C
* Tools: Flex (Lex), Bison (Yacc), GCC
* System Calls: fork, execvp, wait, open, dup2, close, chdir

## 6. Known Limitations
* This version supports single-level command execution and redirection logic as per basic assignment requirements.

---
REWAN HANY
Course: Operating Systems (CSE233)
University: Alamein International University
Due Date: 22/12/2025
