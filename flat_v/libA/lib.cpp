////////////////////////////////////////////////////////////////////////////////
// File      : lib.cpp
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
#include "logger.h"
#include "pubSubModule/pubSubModule.h"
#include "export.h"

namespace libA {

void EXPORT function()
{
   LOG(SEV_DEBUG,  "libA DEBUG message\n");
   LOG(SEV_VERBOSE,"libA VERBOSE message\n");
   LOG(SEV_INFO,   "libA INFO message\n");
   LOG(SEV_WARNING,"libA WARNING message\n");
   LOG(SEV_ERROR,  "libA ERROR message\n");
   LOG(SEV_FORCE,  "libA FORCE message\n");

   std::cout << __FUNCTION__ << " ";
   pubSubModule();
}

}
