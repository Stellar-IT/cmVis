find_package(CLI11 2.5.0 EXACT REQUIRED)
find_package(nlohmann_json 3.12.0 EXACT REQUIRED)

set(CMVIS_TARGET "cmVis")

add_executable("${CMVIS_TARGET}" main.cpp)
target_link_libraries("${CMVIS_TARGET}" PRIVATE CLI11::CLI11 nlohmann_json::nlohmann_json)
