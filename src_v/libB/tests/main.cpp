////////////////////////////////////////////////////////////////////////////////
// File      : main.cpp
// Contents  : tests entry point
//
// Author    : TheBigFred
// URL       : https://github.com/TheBigFred/cmake_examples
//
//-----------------------------------------------------------------------------
//  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
//-----------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

#include <gtest/gtest.h>
#include <iostream>
#include "lib.h"
#include "pubSubModule/pubSubModule.h"

TEST(B,test1)
{
   std::cout << "test " << __FUNCTION__ << " ";
   libB::function();
   libB::pubSubModule();
   EXPECT_TRUE(true);
}


int main(int argc, char **argv)
{
   ::testing::InitGoogleTest(&argc, argv);
   return RUN_ALL_TESTS();
}
