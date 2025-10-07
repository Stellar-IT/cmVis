set(JSON_SOURCE_DIR ${CMAKE_BINARY_DIR}/_deps/json-src)
set(JSON_BINARY_DIR ${EXTERNAL_BUILD_DIR}/json)

FetchContent_Declare(
    json
    OVERRIDE_FIND_PACKAGE
    URL "https://github.com/nlohmann/json/archive/refs/tags/v3.12.0.tar.gz"
    URL_HASH SHA256=4b92eb0c06d10683f7447ce9406cb97cd4b453be18d7279320f7b2f025c10187
)

FetchContent_MakeAvailable(json)

if(NOT EXISTS "${EXTERNAL_INSTALL_DIR}/include/nlohmann/json.hpp")
    file(MAKE_DIRECTORY ${JSON_BINARY_DIR})

    execute_process(
        COMMAND ${CMAKE_COMMAND}
        -S ${JSON_SOURCE_DIR}
        -B ${JSON_BINARY_DIR}
        -DCMAKE_INSTALL_PREFIX=${EXTERNAL_INSTALL_DIR}
        -DCMAKE_INSTALL_LIBDIR=lib
        -DCMAKE_INSTALL_DATAROOTDIR=lib
        -DCMAKE_INSTALL_INCLUDEDIR=include
        -DJSON_BuildTests=OFF
        RESULT_VARIABLE result_configure
    )
    if(NOT result_configure EQUAL 0)
        message(FATAL_ERROR "Failed to configure JSON")
    endif()

    execute_process(
            COMMAND ${CMAKE_COMMAND} --build ${JSON_BINARY_DIR} --target install
            RESULT_VARIABLE result_build
    )
    if(NOT result_build EQUAL 0)
        message(FATAL_ERROR "Failed to build/install JSON")
    endif()
endif()
