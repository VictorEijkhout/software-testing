#include <iostream>
#include <mpl/mpl.hpp>
 
int main() {

  const mpl::communicator &
    world(mpl::environment::comm_world());
  auto tag = mpl::tag_t(25);
  return EXIT_SUCCESS;
}
