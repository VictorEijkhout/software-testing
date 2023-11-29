#include <iostream>
using std::cin, std::cout;

#include <fmt/format.h>

int main(int argc,char **argv) {

    for (int i=10; i<20000; i*=10)
      fmt::print("{:>6}\n",i);

  return 0;
}
