#!/bin/bash

IOS_DEPLOYMENT_TARGET="14.0"

rm -rf build

# Function to build and install for a specific platform
build_platform() {
    build_dir=$1
    cmake_args=$2

    cmake -B $build_dir $cmake_args

    cmake --build "$build_dir" --config Release || {
        echo "Build failed. Exiting."
        exit 1
    }
}

# iPhoneSimulator
sim_platform="iphonesimulator"
build_platform "build/$sim_platform" \
    "-GXcode -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=$IOS_DEPLOYMENT_TARGET \
    -DCMAKE_OSX_SYSROOT=iphonesimulator \
    -DRust_CARGO_TARGET=aarch64-apple-ios-sim \
    -Dcargo_library_path=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk \
    -DCMAKE_OSX_ARCHITECTURES=x86_64;arm64"

macos_platform="macos"
build_platform "build/$macos_platform" \
    "-GXcode -DCMAKE_SYSTEM_NAME=Darwin \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOS_DEPLOYMENT_TARGET \
    -DRust_CARGO_TARGET=aarch64-apple-darwin \
    -DCMAKE_OSX_ARCHITECTURES=$(uname -m)"
