if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/0.18.1/conan.cmake"
                "${CMAKE_BINARY_DIR}/conan.cmake"
                TLS_VERIFY ON)
endif()

# For some weird reason conan.cmake doesn't fall-back to Debug in case of CMAKE_BUILD_TYPE
# not being set. So have to set it explicitly
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR})

function(add_conan_package PACKAGE_NAME PACKAGE_VERSION)
    conan_cmake_configure(REQUIRES ${PACKAGE_NAME}/${PACKAGE_VERSION}
        GENERATORS cmake_find_package)

    conan_cmake_autodetect(CONAN_SETTINGS)

    conan_cmake_install(PATH_OR_REFERENCE .
        BUILD missing
        REMOTE conancenter
        SETTINGS ${CONAN_SETTINGS})
endfunction()
