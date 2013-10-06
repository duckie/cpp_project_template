#include <iostream>
#include <string>
#include <vector>

int main(int argc, char * argv[])
{
  std::vector<std::string> test_vec = {"Hello","guys","!"};
  for(std::string const& elem : test_vec) std::cout << elem << " ";
  std::cout << std::endl;
  return 0;
}

