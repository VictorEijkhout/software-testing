/****************************************************************
 ****
 **** Example tutorial file
 ****
 **** example.i : interface file for C routines
 ****
 ****************************************************************/

%module example
%{
  /* Put header files here or function declarations like below */
  extern double My_variable;
  extern int fact(int n);
  extern int my_mod(int x, int y);
  extern char *get_time();
  %}

extern double My_variable;
extern int fact(int n);
extern int my_mod(int x, int y);
extern char *get_time();
