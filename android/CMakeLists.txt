cmake_minimum_required(VERSION 3.4.1)
set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11 -stdlib=libc++")
SET(CMAKE_EXE_LINKER_FLAGS  "-lopencv_stitching -lopencv_core")
SET(BUILD_SHARED_LIBS ON)
include_directories(${CMAKE_SOURCE_DIR}/src/main/includes)
file(GLOB CVLIBS
        "C:/opencv/OpenCV-android-sdk/sdk/native/staticlibs/${ANDROID_ABI}/libopencv_stitching.a")
add_library(native_opencv SHARED src/main/jni/native_opencv.cpp)
add_library(lib_opencv SHARED IMPORTED)
set_target_properties(lib_opencv PROPERTIES IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/src/main/jniLibs/${ANDROID_ABI}/libopencv_java4.so)
find_library(log-lib
        log)
target_link_libraries(native_opencv ${CVLIBS} ${log-lib} lib_opencv)
