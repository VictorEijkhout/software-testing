#include <fftw3.h>

int main() {
  float *p;
  int a = fftw_alignment_of(p);
  printf("%d\n",a);

  return 0;
}
