#include <iostream>
#include <boost/filesystem.hpp>

int main() {

  try {
    boost::filesystem::path path("./");
    std::cout << "Current path: " <<boost::filesystem::absolute(path) << std::endl;
  } catch ( std::bad_alloc ) {
    std::cout << "Unexplained bad alloc\n";
    throw;
  }

  return 0;
}
