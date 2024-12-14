#include "Test/Test.hpp"
#include "cxxbridge/lib.h"

std::shared_ptr<Test> Test::s_instance = nullptr;

// Initialization method
void Test::initialize() {
  if (!s_instance) {
    s_instance = std::shared_ptr<Test>(new Test());
  }
  rust::rust_echo(12);
}

std::shared_ptr<Test> Test::instance() {
  if (!s_instance) {
    throw std::runtime_error("Test: Test::initialize must be called before Test::instance.");
  }
  return s_instance;
}
