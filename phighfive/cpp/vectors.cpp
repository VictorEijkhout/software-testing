#include <highfive/highfive.hpp>

#include <numeric> // for iota
#include <string>
using std::string;

using namespace HighFive;

int main() {
  std::string filename = "./vectors_file.h5";

  {
    //codesnippet hi5datawrite2
    std::vector<int>  data1 = {1,2,3,4,5};
    std::vector<string> data2 = {"a","b","c","d","e"};
    File file(filename,File::Truncate);
    file.createDataSet("grp/data1", data1);
    file.createDataSet("grp/data2", data2);
    //codesnippet end
  }

  {
    // We open the file as read-only:
    //codesnippet hi5dataread2
    File file(filename, File::ReadOnly);
    auto dataset1 = file.getDataSet("grp/data1");
    auto dataset2 = file.getDataSet("grp/data2");
    // Read back, with allocating:
    auto data2 = dataset2.read<std::vector<string>>();
    auto data1 = dataset1.read<std::vector<int>>();
    dataset2.read(data2);
    dataset1.read(data1);
    //codesnippet end
  }

  return 0;
}
