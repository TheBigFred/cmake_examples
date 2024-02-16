////////////////////////////////////////////////////////////////////////////////
// File      : main.cpp
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

#include <libA/logger.h>

#include <libB/lib.h>
#include <libB/logger.h>
#include <libB/version.h>

#include "logger.h"
#include "version.h"
#include "subModule1/subModule.h"
#include "subModule2/subModule.h"
using namespace App;
   

void Logger(void* self, uint32_t severity, const char* msg, va_list args)
{
   if (severity)
   {
      vfprintf(reinterpret_cast<FILE*>(self), msg, args);
   }
}

int main()
{
   // Configure loggers
   auto logFile = fopen("log.txt", "wb");
   if (logFile != nullptr)
   {
      libA::SetLogger(Logger, logFile);
      libA::SetMinimumSeverity(libA::SEV_INFO);

      libB::SetLogger(Logger, logFile);
      libB::SetMinimumSeverity(libB::SEV_INFO);

      App::SetLogger(Logger, logFile);
      App::SetMinimumSeverity(App::SEV_INFO);
   }


#ifdef HELLO_WORLD_SUPPORT
   cout << "Hello World!!!" << endl;
#endif

   Log(SEV_DEBUG,  "App DEBUG message\n");
   LOG(SEV_DEBUG,  "App DEBUG message\n");
   LOG(SEV_VERBOSE,"App VERBOSE message\n");
   LOG(SEV_INFO,   "App INFO message\n");
   LOG(SEV_WARNING,"App WARNING message\n");
   LOG(SEV_ERROR,  "App ERROR message\n");
   LOG(SEV_FORCE,  "App FORCE message\n");

   //libA::function(); std::cout << std::endl;
   libB::function();  std::cout << std::endl;
   //libB::pubSubModule(); std::cout << std::endl;
   App::subModule1(); std::cout << std::endl;
   App::subModule2(); std::cout << std::endl;

   std::cout << libB::versionStr() << std::endl;
   std::cout << App::versionStr() << std::endl;

   return 0;
}
