Program BlacsGridinit
  !! use scalapack : there are no modules.
  external :: blacs_gridinit
  call blacs_gridinit()
  stop
End Program BlacsGridinit
