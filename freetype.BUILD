load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "freetype",
lib_source = "@freetype//:freetype-2.9.1",

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
        "freetype.lib"
    ],
    "//conditions:default": [
        "libfreetype.a"
    ]
}),

deps = [
   "@zlib//:zlib"
],

cache_entries = {
   "SKIP_INSTALL_HEADERS": "NO"
},

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": None
}),

cmake_options = select({
    "@bazel_tools//src/conditions:windows": ["-GNinja"],
    "//conditions:default": None
}),

make_commands = select({
   "@bazel_tools//src/conditions:windows": [
        "ninja",
        # Ninja install is broken
        "mkdir -p freetype/lib",
        "cp freetype.lib freetype/lib"
   ],
   "//conditions:default": [
       "make -j$(nproc)",
       "make install"
   ]
}),

visibility = ["//visibility:public"]
) 
