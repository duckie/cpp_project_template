# Add 3rdparty for main file
macro(enable_3rdparty name)
  add_subdirectory(3rdparty/${name})
endmacro(enable_3rdparty)

# Add module for main file
macro(enable_module name)
  add_subdirectory(src/${name})
endmacro(enable_module)
