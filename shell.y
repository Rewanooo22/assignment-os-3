%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>

void yyerror(const char *s);
int yylex();

char *arg_list[100];
int arg_count = 0;
char *input_file = NULL;
char *output_file = NULL;
int append_mode = 0;

void execute_command() {
    if (arg_count == 0) return;
    arg_list[arg_count] = NULL;

    if (strcmp(arg_list[0], "exit") == 0) exit(0);
    
    if (strcmp(arg_list[0], "cd") == 0) {
        if (arg_count > 1 && chdir(arg_list[1]) != 0) perror("cd failed");
        arg_count = 0; return;
    }

    if (strcmp(arg_list[0], "pwd") == 0) {
        char cwd[1024];
        if (getcwd(cwd, sizeof(cwd)) != NULL) printf("%s\n", cwd);
        arg_count = 0; return;
    }

    pid_t pid = fork();
    if (pid == 0) {
        if (input_file) {
            int fd = open(input_file, O_RDONLY);
            if (fd >= 0) { dup2(fd, STDIN_FILENO); close(fd); }
        }
        if (output_file) {
            int flags = O_WRONLY | O_CREAT | (append_mode ? O_APPEND : O_TRUNC);
            int fd = open(output_file, flags, 0644);
            if (fd >= 0) { dup2(fd, STDOUT_FILENO); close(fd); }
        }
        execvp(arg_list[0], arg_list);
        exit(1);
    } else {
        wait(NULL);
    }
    arg_count = 0; input_file = NULL; output_file = NULL; append_mode = 0;
}
%}

%union { char *string; }
%token <string> WORD
%token NEWLINE PIPE REDIRECT_IN REDIRECT_OUT REDIRECT_APPEND

%%

start: 
    | start line
    ;

line: 
    NEWLINE { printf("minishell> "); }
    | full_command NEWLINE { execute_command(); printf("minishell> "); }
    ;

full_command: 
    command redirection_list
    ;

command: 
    WORD { arg_list[arg_count++] = strdup($1); }
    | command WORD { arg_list[arg_count++] = strdup($2); }
    ;

redirection_list:
    | redirection_list redirection
    ;

redirection:
    REDIRECT_IN WORD { input_file = strdup($2); }
    | REDIRECT_OUT WORD { output_file = strdup($2); append_mode = 0; }
    | REDIRECT_APPEND WORD { output_file = strdup($2); append_mode = 1; }
    ;

%%

void yyerror(const char *s) {}

int main() {
    printf("minishell> ");
    yyparse();
    return 0;
}
