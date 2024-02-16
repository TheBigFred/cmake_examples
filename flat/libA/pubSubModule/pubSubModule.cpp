////////////////////////////////////////////////////////////////////////////////
// File      : pubSubModule.cpp
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
#include "../priSubModule/priSubModule.h"

namespace libA {

void pubSubModule()
{
   std::cout << __FUNCTION__ << " ";
   priSubModule();
}

}
