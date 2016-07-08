# Add 3rdparty for main file
macro(project_add_3rdparty name)
  add_subdirectory(3rdparty/${name})
endmacro(project_add_3rdparty)

# Add module for main file
macro(project_add_module name)
  add_subdirectory(src/${name})
endmacro(project_add_module)
