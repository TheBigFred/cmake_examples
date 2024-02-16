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
#include <libA/lib.h>
#include "logger.h"
#include "pubSubModule/pubSubModule.h"

namespace libB {

void function()
{
   LOG(SEV_DEBUG,  "libB DEBUG message\n");
   LOG(SEV_VERBOSE,"libB VERBOSE message\n");
   LOG(SEV_INFO,   "libB INFO message\n");
   LOG(SEV_WARNING,"libB WARNING message\n");
   LOG(SEV_ERROR,  "libB ERROR message\n");
   LOG(SEV_FORCE,  "libB FORCE message\n");

   std::cout << __FUNCTION__ << " ";
   pubSubModule();
   libA::function();
}

}
