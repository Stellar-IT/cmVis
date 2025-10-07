#include <CLI/CLI.hpp>


int main(int argc, char** argv) {
  CLI::App app{"cmVis - visualize your CMake build"};

  std::vector<std::string> outputs;
  app.add_option("-o,--output", outputs, "Output formats (svg, html, dot)");

  std::string input = "build/.cmake/api/v1/reply";
  app.add_option("-i,--input", input, "Path to CMake File API reply dir");

  bool verbose = false;
  app.add_flag("-v,--verbose", verbose, "Enable verbose logging");

  CLI11_PARSE(app, argc, argv);

  // Example usage
  for (auto& o : outputs)
    std::cout << "Will generate: " << o << "\n";

  return 0;
}