Program FFTtestFortran
  use iso_c_binding
  implicit none
  
#include "fftw3.f03"
  
  double complex in, out
  integer,parameter :: N=100
  dimension in(N), out(N)
  integer*8 plan

  call dfftw_plan_dft_1d(plan,N,in,out,FFTW_FORWARD,FFTW_ESTIMATE)
  call dfftw_execute_dft(plan, in, out)
  call dfftw_destroy_plan(plan)

end Program FFTtestFortran
