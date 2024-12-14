CMAKE_MINIMUM_REQUIRED(VERSION 3.19)

set(FETCHCONTENT_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/../_deps/${CMAKE_GENERATOR}")

PROJECT("Test")

set(SOURCES
  ${CMAKE_CURRENT_LIST_DIR}/cpp/src/Test.cpp
)

set(HEADERS
  ${CMAKE_CURRENT_LIST_DIR}/cpp/include/Test/Test.hpp
)

add_library("Test" SHARED ${HEADERS} ${SOURCES})

target_include_directories("Test"
    PUBLIC
        ${CMAKE_CURRENT_LIST_DIR}/cpp/include
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/cpp/src
)

### DEPENDENCIES

include(FetchContent)

FetchContent_Declare(
    Corrosion
    GIT_REPOSITORY https://github.com/corrosion-rs/corrosion.git
    GIT_TAG v0.5
)
FetchContent_MakeAvailable(Corrosion)

corrosion_import_crate(
        MANIFEST_PATH ${CMAKE_CURRENT_LIST_DIR}/rust/Cargo.toml
)

corrosion_add_cxxbridge(cxxbridge
        CRATE rust
        FILES lib.rs
)

target_link_libraries("Test" cxxbridge)

