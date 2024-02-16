#!/bin/bash

set -e # Add directives to exit on error (-e)
set -u # Add directives to consider uninitialized variables as an error

PRESET=(shared static)
BUILDTYPE=(Release Debug)
GENERATOR=("Unix Makefiles" Ninja "Ninja Multi-Config")

for g in "${GENERATOR[@]}"
do
   ./clean.sh
   for p in "${PRESET[@]}"
   do
      for b in "${BUILDTYPE[@]}"
      do
         echo "==============================================================================="
         echo "Superbuild - $p-$b - $g"
         echo "==============================================================================="
         export configPostfix=-$b
         cmake --preset $p -G"$g"
         cmake --build _build-$p-$b --clean-first --config $b --target install package -- -j$(nproc)
         ctest --test-dir _build-$p-$b -C $b
      done
   done

   ldd _install-shared-Release/bin/App
   #ldd _install-shared-Debug/bin/App
   ldd _install-static-Release/bin/App
   #ldd _install-static-Debug/bin/App
   #read -p "Press [ENTER] to continue ..."
done

#read -p "Press [ENTER] to continue ..."

GENERATOR=("Unix Makefiles" Ninja "Ninja Multi-Config")
ITEM=(libA libB App)
for g in "${GENERATOR[@]}"
do
   ./clean.sh
   for p in "${PRESET[@]}";
   do
      for i in "${ITEM[@]}";
      do
         cd $i
         for b in "${BUILDTYPE[@]}";
         do
            echo "==============================================================================="
            echo "Standalone - $p - $b - $i - $g"
            echo "==============================================================================="
            export configPostfix=-$b
            cmake --preset $p -G"$g"
            cmake --build _build-$p-$b --clean-first --config $b --target install package -- -j$(nproc)
            ctest --test-dir _build-$p-$b -C $b
         done
         cd ..
      done
   done
done
echo Done!