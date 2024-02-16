@echo off
set cwd="%cd%"
set PRESET=static shared

for %%p in (%PRESET%)do (
    echo:
    echo ===============================================================================
    echo Superbuild - %%p
    echo ===============================================================================
    "C:\Program Files\CMake\bin\cmake" --preset %%p
    if errorlevel 1 exit /B
    "C:\Program Files\CMake\bin\cmake" --build _build-%%p --clean-first --config Release --target install package
    if errorlevel 1 exit /B
    "C:\Program Files\CMake\bin\cmake" --build _build-%%p --clean-first --config Debug --target install package
    if errorlevel 1 exit /B
    "C:\Program Files\CMake\bin\ctest" --test-dir _build-%%p -C Release
    if errorlevel 1 exit /B
    "C:\Program Files\CMake\bin\ctest" --test-dir _build-%%p -C Debug
    if errorlevel 1 exit /B
)

rem pause

rem set ITEMS="%cd%\LIBA" "%cd%\LIBB" "%cd%\APP"

rem for %%p in (%PRESET%)do (
rem     for  %%i in (%ITEMS%) do (
rem         cd  %%i
rem         echo:
rem         echo ===============================================================================
rem         echo Standalone - %%p -%%i
rem         echo ===============================================================================           
rem         "C:\Program Files\CMake\bin\cmake" --preset %%p
rem         if errorlevel 1 exit /B
rem         "C:\Program Files\CMake\bin\cmake" --build _build-%%p  --config Release --target install package
rem         if errorlevel 1 exit /B
rem         "C:\Program Files\CMake\bin\cmake" --build _build-%%p  --config Debug --target install package
rem         if errorlevel 1 exit /B
rem         "C:\Program Files\CMake\bin\ctest" --test-dir _build-%%p -C Release
rem         if errorlevel 1 exit /B
rem         "C:\Program Files\CMake\bin\ctest" --test-dir _build-%%p -C Debug
rem         if errorlevel 1 exit /B
rem     )
rem )

cd %cwd%
_install-shared-Release\bin\App.exe
_install-shared-Debug\bin\App_d.exe

_install-static-Release\bin\App.exe
_install-static-Debug\bin\App_d.exe
