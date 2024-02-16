These are some CMake examples.

Folders with the postfix "_v" (meaning "_visibility") are examples of symbol visibility management for dynamic libraries.

Folders without postfixes are examples where all symbols are exported.

"flat" folders are examples where sources are in the root folder.
"src" folders are examples where sources are in a src subfolder.

Each folders contains:
 - libA: a library without dependencies.
 - libB: a library with a dependency on libA.
 - App: an application using libB.

Each CMakeLists.txt has been written in such a way that it can be called from another CMakeLists.txt.

The cpack folder, the CMakeLists.txt and CMakePresets.json files for each type of example are here to test a sort of "superbuild" mode.

Each library and application must have its own git repository. The cpack folder, the CMakeLists.txt and CMakePresets.json files should be stored in a separate repo. It's up to you to put it all together. The superbuild folder is just a copy of these files.
