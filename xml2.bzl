load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def xml2():
    # Load Bullet
    maybe(
        new_git_repository,
        name = "xml2",
        remote = "https://gitlab.gnome.org/GNOME/libxml2.git",

        commit = "a67b63d183f5ab5d5af70fe47ef3a3d53fa3cb09",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "xml2_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)
# export VS160COMNTOOLS="/c/Program Files (x86)/Microsoft Visual Studio/2019/Community/Common7/Tools"
cmake_external(
name = "xml2",
lib_source = ":xml2_files",

cache_entries = {
    "LIBXML2_WITH_LZMA": "OFF",
    "LIBXML2_WITH_PYTHON": "OFF",
    "LIBXML2_WITH_ICONV": "OFF",
    "Iconv_LIBRARY": "$EXT_BUILD_DEPS/iconv/lib/iconv.lib",
    "Iconv_INCLUDE_DIR": "$EXT_BUILD_DEPS/iconv/include"
},

# Windows only
generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": False
}),

cmake_options = select({
   "@bazel_tools//src/conditions:windows": ["-GNinja"],
   "//conditions:default": None
}),

make_commands = select({
   "@bazel_tools//src/conditions:windows": [
       "ninja",
       "ninja install"
   ],
   "//conditions:default": [
       "make -j$(nproc)",
       "make install"
   ]
}),

deps = [
    "@zlib//:zlib"
],

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [],
    "//conditions:default": [
        "libxml2.so",
        "libxml2.so.2.9.10"
    ]
}),

static_libraries = select({
    "@bazel_tools//src/conditions:windows": ["libxml2.lib"],
    "//conditions:default": []
}),

visibility = ["//visibility:public"]
)
        """
    )
