program test
  use iso_c_binding
  implicit none
  
  integer, pointer :: a(:), b(:)
  type(c_ptr) :: cptr
  allocate(a(2))
  a(1)=1
  a(2)=2
  cptr = c_loc(a)
  call c_f_pointer(cptr,b,[2])
  print *,b(1:2)
  deallocate(b)
end program test
