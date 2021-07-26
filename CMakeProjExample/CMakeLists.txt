cmake_minimum_required(VERSION 3.18)

project(CMakeProjExample
        VERSION 0.0
        DESCRIPTION "CMakeProjExample"
        LANGUAGES CXX C)

message("\n\n\nProject: ${PROJECT_NAME} added to Main Project: ${CMAKE_PROJECT_NAME}")

# Only do these if this is the main project, and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)

endif()

# Options
option(CUDA_ENABLE "CUDA_ENABLE" OFF)
#


# Definitions
add_definitions(-DVolSpecType=float)
#add_definitions(-DTemp4Ron)
add_definitions(-DPIP_DEBUG_DUMP)
if(CUDA_ENABLE)
    add_definitions(-DUSE_GPU)
endif()
#

# Packages
if(CUDA_ENABLE)
      find_package(CUDAToolkit)
endif()
find_package(HDF5 REQUIRED)
find_package(Boost 1.72.0 COMPONENTS thread system filesystem date_time timer chrono regex REQUIRED)
find_package(GTest REQUIRED)
find_package(OpenCV REQUIRED)
#

# code
add_subdirectory(Examples)




message("\n\n\n")
