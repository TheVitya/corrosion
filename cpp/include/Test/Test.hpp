#pragma once

#include <iostream>

class Test {
public:
  Test() = default;
  Test& operator=(Test const&) = delete;

  static std::shared_ptr<Test> instance();

  static void initialize();

private:
  static std::shared_ptr<Test> s_instance;
};
