# Find Doxygen
find_package(Doxygen REQUIRED)

if(NOT DOXYGEN_FOUND)
    message(FATAL_ERROR "Doxygen is required to build the documentation")
else()
    message(STATUS "Found Doxygen: ${DOXYGEN_EXECUTABLE}")
endif()

# Check for Graphviz dot
find_program(GRAPHVIZ_DOT_EXECUTABLE dot)

if(NOT GRAPHVIZ_DOT_EXECUTABLE)
    message(FATAL_ERROR "Graphviz (dot) not found. It is required to build documentation.")
else()
    message(STATUS "Found Graphviz: ${GRAPHVIZ_DOT_EXECUTABLE}")
endif()

# configure Doxygen
set(DOXYGEN_IN ${CMAKE_SOURCE_DIR}/docs/Doxyfile.in)
set(DOXYGEN_OUT ${CMAKE_BINARY_DIR}/Doxyfile)
set(DOXYGEN_DOT_EXECUTABLE "${GRAPHVIZ_DOT_EXECUTABLE}")

configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

add_custom_target(doc_doxygen
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating API documentation with Doxygen"
    VERBATIM
)
