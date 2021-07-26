

if(CUDA_ENABLE)
    project(${PROJ_NAME} LANGUAGES CXX CUDA)
else()
    project(${PROJ_NAME} LANGUAGES CXX)
endif()


function(set_lib_pip)
    cmake_parse_arguments("" 0 "LIB_NAME" "SOURCES;INCLUDE_LIBS;COMPILE_OPT"  ${ARGN} )

    add_library(${_LIB_NAME} ${_SOURCES})
    
    if(CUDA_ENABLE)
        message("Generating Library ${_LIB_NAME} with CUDA Supported - ${PROJECT_NAME}")
    
        set_property(TARGET ${_LIB_NAME}    PROPERTY CUDA_ARCHITECTURES 60 61 75)
        target_compile_features(${_LIB_NAME} PUBLIC  cxx_std_17 cuda_std_14)
        set_property(TARGET ${_LIB_NAME} PROPERTY CUDA_SEPARABLE_COMPILATION ON)
    
    else()
        message(" ")
        message("Generating Library ${_LIB_NAME} without CUDA Supported - ${PROJECT_NAME}")
    
        target_compile_features(${_LIB_NAME} PUBLIC  cxx_std_17)
    
    endif()

    if ("${_INCLUDE_LIBS}" STREQUAL "NONE")
        message("no target_link_libraries")
    else()
        target_link_libraries(${_LIB_NAME} PUBLIC ${_INCLUDE_LIBS})
    endif()

    target_include_directories(${_LIB_NAME} PUBLIC include)

    if ("${_COMPILE_OPT}" STREQUAL "NONE")
        message("no target_compile_options")
    elseif ("${_COMPILE_OPT}" STREQUAL "")
        target_compile_options(${_LIB_NAME} PRIVATE -Wall -Wconversion -Wextra -pedantic)
    else()
        message("target_compile_options - ${_COMPILE_OPT}")
        target_compile_options(${_LIB_NAME} PRIVATE ${_COMPILE_OPT})
    endif()
    
    if(CUDA_ENABLE)
        target_compile_options(${_LIB_NAME} PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:
        --generate-line-info
        --use_fast_math
        >)
    endif()
    message(" ")
    message(" ")
endfunction()


function(set_exec_pip)
    cmake_parse_arguments("" 0 "EXEC_NAME" "SOURCES;INCLUDE_LIBS;COMPILE_OPT"  ${ARGN} )

    add_executable(${_EXEC_NAME} ${_SOURCES})
    
    if(CUDA_ENABLE)
        message("Generating Executable ${_EXEC_NAME} with CUDA Supported - ${PROJECT_NAME}")
       
        set_property(TARGET ${_EXEC_NAME}    PROPERTY CUDA_ARCHITECTURES 60 61 75)

        target_compile_features(${_EXEC_NAME} PRIVATE  cxx_std_17 cuda_std_14)
        set_property(TARGET ${_EXEC_NAME} PROPERTY CUDA_SEPARABLE_COMPILATION ON)

    else()
        message("Generating Executable ${_EXEC_NAME} without CUDA Supported - ${PROJECT_NAME}")
    
        target_compile_features(${_EXEC_NAME} PRIVATE  cxx_std_17)
    
    endif()
    
    target_link_libraries(${_EXEC_NAME} PUBLIC ${_INCLUDE_LIBS})

    if ("${_COMPILE_OPT}" STREQUAL "NONE")
        message("no target_compile_options")
    elseif ("${_COMPILE_OPT}" STREQUAL "")
        target_compile_options(${_EXEC_NAME} PUBLIC -Wall -Wconversion -Wextra -pedantic)
    else()
        message("target_compile_options: ${_COMPILE_OPT}")
        target_compile_options(${_EXEC_NAME} PUBLIC ${_COMPILE_OPT})
    endif()

    message(" ")
    message(" ")
endfunction()

