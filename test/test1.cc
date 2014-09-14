#include <gtest/gtest.h>
#include <project.h>

class UnitTests : public ::testing::Test {
 protected:
   int fixture = 1;
};

TEST_F(UnitTests, Test1) {
  EXPECT_EQ(1, fixture);
  EXPECT_EQ("Hello guys !", project::function());
}

