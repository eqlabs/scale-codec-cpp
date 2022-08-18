# Hunter forces us to specify all libs that we want at once so
# we have no other options than to check it here
if (BUILD_TESTS)
    set(BOOST_WITHOUT_RANDOM "False")
else()
    set(BOOST_WITHOUT_RANDOM "True")
endif()
add_conan_package(boost 1.72.0
    CONFIG_OPTIONS
    boost:without_atomic=True
    boost:without_chrono=True
    boost:without_container=True
    boost:without_context=True
    boost:without_contract=True
    boost:without_coroutine=True
    boost:without_date_time=True
    boost:without_exception=True
    boost:without_fiber=True
    boost:without_filesystem=True
    boost:without_graph=True
    boost:without_graph_parallel=True
    boost:without_iostreams=True
    boost:without_json=True
    boost:without_locale=True
    boost:without_log=True
    boost:without_math=True
    boost:without_mpi=True
    boost:without_nowide=True
    boost:without_program_options=True
    boost:without_python=True
    boost:without_random=${BOOST_WITHOUT_RANDOM}
    boost:without_regex=True
    boost:without_serialization=True
    boost:without_stacktrace=True
    boost:without_system=True
    boost:without_test=True
    boost:without_thread=True
    boost:without_timer=True
    boost:without_type_erasure=True
    boost:without_wave=True)
find_package(Boost MODULE REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
