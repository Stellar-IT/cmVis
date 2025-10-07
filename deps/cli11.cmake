set(CLI11_SOURCE_DIR ${CMAKE_BINARY_DIR}/_deps/cli11-src)
set(CLI11_BINARY_DIR ${EXTERNAL_BUILD_DIR}/cli11)

FetchContent_Declare(
    cli11
    OVERRIDE_FIND_PACKAGE
    URL "https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.5.0.tar.gz"
    URL_HASH SHA256=17e02b4cddc2fa348e5dbdbb582c59a3486fa2b2433e70a0c3bacb871334fd55
)

FetchContent_MakeAvailable(cli11)

if(NOT EXISTS "${EXTERNAL_INSTALL_DIR}/include/CLI/CLI.hpp")
    file(MAKE_DIRECTORY ${CLI11_BINARY_DIR})

    execute_process(
        COMMAND ${CMAKE_COMMAND}
        -S ${CLI11_SOURCE_DIR}
        -B ${CLI11_BINARY_DIR}
        -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_DIR}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DCMAKE_INSTALL_DATAROOTDIR=lib
        -DCMAKE_INSTALL_INCLUDEDIR=include
        -DCLI11_BUILD_TESTS=OFF
        -DCLI11_BUILD_EXAMPLES=OFF
        RESULT_VARIABLE result_configure
    )
    if(NOT result_configure EQUAL 0)
        message(FATAL_ERROR "Failed to configure CLI11")
    endif()

    execute_process(
            COMMAND ${CMAKE_COMMAND} --build ${CLI11_BINARY_DIR} --target install
            RESULT_VARIABLE result_build
    )
    if(NOT result_build EQUAL 0)
        message(FATAL_ERROR "Failed to build/install CLI11")
    endif()
endif()
