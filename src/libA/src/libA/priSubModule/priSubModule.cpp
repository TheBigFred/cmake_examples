////////////////////////////////////////////////////////////////////////////////
// File      : priSubModule.cpp
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
#include "version.h"

namespace libA {

void priSubModule()
{
   std::cout << versionStr() << " " << __FUNCTION__ << " ";
}

}
