program test_citations
  use m_cite
  implicit none
  
  ! Initialize citation system
  call init_citation('test_output')
  
  ! Add some citations
  ! Primary SIESTA paper
  call add_citation("10.1088/0953-8984/14/11/302")
  
  ! TranSiesta paper
  call add_citation("10.1103/PhysRevB.65.165401")
  
  ! Try adding the same paper twice (should only appear once in output)
  call add_citation("10.1088/0953-8984/14/11/302")
  
  ! Try a non-existent DOI (should be silently ignored)
  call add_citation("10.0000/not.exists")
  
  ! ELPA library
  call add_citation("10.1088/0953-8984/26/21/213201")
  
  ! Print summary with version
  call announce_citations("TEST-1.0")

end program test_citations