Cpp project template
====================

This is a layout to bootstrap a complete C++ project with several modules and test code. The directory layout looks over engineered for so small a source code, but it aims at being able to scale with a lot of files, modules and 3rdparties while avoiding clutter and name conflicts.

The actual source has three modules:
* *projectlib* is the business code of a library, with public headers and compilation units. The `projectlib` directory name is replicated for public headers to keep consistency with system wide deployment through a package.
* *projectrun* contains only compilation units and is a business executable.
* *testlib* contains only compilation units (yet) and is supposed to hold test code, objects and tools shared by the other modules.

Non system third parties are supposed to be stored or referenced (either via copy, submodule or _CMake_ external project) in the `3rdparty` directory. System third parties may be referenced to directly with _CMake_ modules.

To compile and launch :

```bash
mkdir build
cd build
cmake ../
make
./src/CppProject
```
