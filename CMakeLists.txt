cmake_minimum_required(VERSION 3.4...3.18)

project(
  cmake_example
  VERSION 0.1
  DESCRIPTION "python extension module template using pybind11"
  LANGUAGES CXX)

add_subdirectory(CMakeProjExample)

add_subdirectory(pybind11)
pybind11_add_module(cmake_example src/main.cpp)

# EXAMPLE_VERSION_INFO is defined by setup.py and passed into the C++ code as a
# define (VERSION_INFO) here.
target_compile_definitions(cmake_example PRIVATE VERSION_INFO=${EXAMPLE_VERSION_INFO})
