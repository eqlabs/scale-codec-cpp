add_conan_package(boost 1.72.0)
find_package(Boost MODULE REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
