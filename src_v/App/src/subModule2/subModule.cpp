////////////////////////////////////////////////////////////////////////////////
// File      : subModule.cpp
// Contents  : 
//
// Author    : TheBigFred
// URL       : https://github.com/TheBigFred/cmake_examples
//
//-----------------------------------------------------------------------------
//  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
//-----------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////

#include <iostream>
#include "../subModule1/subModule.h"

namespace App {

void subModule2()
{
   std::cout << __FUNCTION__;
   subModule1();
}

}
