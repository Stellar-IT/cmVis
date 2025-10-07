set(GTEST_SOURCE_DIR ${CMAKE_BINARY_DIR}/_deps/gtest-src)
set(GTEST_BINARY_DIR ${EXTERNAL_BUILD_DIR}/gtest)

FetchContent_Declare(
    gtest
    OVERRIDE_FIND_PACKAGE
    URL "https://github.com/google/googletest/releases/download/v1.17.0/googletest-1.17.0.tar.gz"
    URL_HASH SHA256=65fab701d9829d38cb77c14acdc431d2108bfdbf8979e40eb8ae567edf10b27c
)

FetchContent_GetProperties(gtest)
if(NOT gtest_POPULATED)
    FetchContent_Populate(gtest)
endif()

if(NOT EXISTS "${EXTERNAL_INSTALL_DIR}/lib/libgtest.a")
    file(MAKE_DIRECTORY ${GTEST_BINARY_DIR})

    execute_process(
        COMMAND ${CMAKE_COMMAND}
        -S ${GTEST_SOURCE_DIR}
        -B ${GTEST_BINARY_DIR}
        -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_DIR}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DCMAKE_INSTALL_DATAROOTDIR=lib
        -DCMAKE_INSTALL_INCLUDEDIR=include
        RESULT_VARIABLE result_configure
    )
    if(NOT result_configure EQUAL 0)
        message(FATAL_ERROR "Failed to configure GTEST")
    endif()

    execute_process(
            COMMAND ${CMAKE_COMMAND} --build ${GTEST_BINARY_DIR} --target install
            RESULT_VARIABLE result_build
    )
    if(NOT result_build EQUAL 0)
        message(FATAL_ERROR "Failed to build/install GTEST")
    endif()
endif()
