#
# Copyright Soramitsu Co., Ltd. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#

cmake_minimum_required(VERSION 3.12)

option(BUILD_TESTS "Whether to include the test suite in build" OFF)
set(PACKAGE_MANAGER "Hunter" CACHE STRING "Package manager for 3rdparties")
set(SUPPORTED_PACKAGE_MANAGERS "Hunter" "Conan")
if (NOT ${PACKAGE_MANAGER} IN_LIST SUPPORTED_PACKAGE_MANAGERS)
    message(FATAL_ERROR "Uknown package manager specified: \"${PACKAGE_MANAGER}\". Valie options: ${SUPPORTED_PACKAGE_MANAGERS}")
endif()
include("${CMAKE_CURRENT_LIST_DIR}/cmake/${PACKAGE_MANAGER}/Init.cmake")

project(Scale LANGUAGES CXX VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include("${CMAKE_CURRENT_LIST_DIR}/cmake/${PACKAGE_MANAGER}/Boost.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/cmake/${PACKAGE_MANAGER}/Microsoft.GSL.cmake")

add_subdirectory(src)

if (BUILD_TESTS)
    enable_testing()
    add_subdirectory(test ${CMAKE_BINARY_DIR}/tests_bin)
endif ()

###############################################################################
#   INSTALLATION
###############################################################################

include(GNUInstallDirs)

install(TARGETS scale buffer scale_encode_append EXPORT scaleConfig
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FRAMEWORK DESTINATION ${CMAKE_INSTALL_PREFIX}
    )

install(
    DIRECTORY ${CMAKE_SOURCE_DIR}/include/scale
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/scaleConfigVersion.cmake
    COMPATIBILITY SameMajorVersion
)

install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/scaleConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/scale
)

install(
    EXPORT scaleConfig
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/scale
    NAMESPACE scale::
)
