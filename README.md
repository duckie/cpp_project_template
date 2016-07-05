Cpp project template
====================

This is a simple project to layout a complete C++ project with several modules and test code. The directory layout looks over engineered for so small a source code, but it aims at being able to scale with a lot of files, modules and 3rdparties while avoiding clutter and name conflicts.

The actual source has three modules:
* _projectlib_ is the business code of a library, with public headers and compilation units. The `projectlib` directory name is replicated for public headers to keep consistency with system wide deployment through a package.
* _projectrun_ contains only compilation units and is a business executable.
* _testlib_ contains only compilation units (yet) and is supposed to hold test code, objects and tools shared by the other modules.

Non system third parties are to supposed to be stored or referenced (either via copy, submodule or CMake external project) in the `3rdparties` directory. System third parties may be referenced to directly with CMake modules.

To compile and launch :

```bash
mkdir build
cd build
cmake ../
make
./src/CppProject
```
