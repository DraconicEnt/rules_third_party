load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def tiff():
    maybe(
        http_archive,
        name = "tiff",
        url = "https://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz",
        sha256 = "5d29f32517dadb6dbcd1255ea5bbc93a2b54b94fbf83653b4d65c7d6775b8634",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "tiff",
lib_source = "@tiff//:tiff-4.1.0",

#static_libraries = [
   #"tiff.lib"
#   "libport.a"
#],

shared_libraries = [
    "libtiff.so"
],

# Windows only
generate_crosstool_file = True,
cmake_options = ["-GNinja"],
make_commands = [
   "ninja",
   "ninja install",
],

visibility = ["//visibility:public"]
)
        """
    )
