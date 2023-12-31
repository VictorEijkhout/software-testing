#include <iostream>
using std::cin, std::cout;
#include <vector>
using std::vector;

#include "mdspan/mdspan.hpp"
namespace md = Kokkos;

int main(int argc,char **argv) {

  constexpr int N=10;
  vector<float> A(N*N);
  md::mdspan Amd{ A.data(),N,N };

  return 0;
}
