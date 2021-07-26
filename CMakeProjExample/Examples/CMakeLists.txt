set(PROJ_NAME Examples)

include(${PROJECT_SOURCE_DIR}/config.cmake)

add_library(pet INTERFACE) 

target_include_directories(pet INTERFACE include/) 
