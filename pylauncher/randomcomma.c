/****************************************************************
 *
 * This example program is part of the pylauncher distribution
 * copyright Victor Eijkhout 2020
 *
 * Usage: randomsleep t [ tmax ]
 * -- if tmax not given: random sleep up to `t' seconds
 * -- if tmax given    : random sleep time in [t,tmax] interval
 *
 ****************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(int argc,char **argv) {
  srand(time(NULL));

  int tmin,tmax;

  switch (argc) {
  case 2 : 
    sscanf(argv[1],"%d,%d",&tmin,&tmax);
    printf("parsed %s as %d,%d\n",argv[1],tmin,tmax);
    break;
  default:
    printf("Usage: randomcomma tmin,tmax\n"); 
    return 0;
  }

  int nseconds;
  if (tmin==tmax)
    nseconds = tmin;
  else 
    nseconds = tmin + rand() % (tmax-tmin);

  printf("I am going to sleep for %d seconds\n",nseconds);
  sleep(nseconds);
  printf("There. I did it.\n");
  return 0;
}
