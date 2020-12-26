load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

cmake_external(
name = "curl",
lib_source = "@curl//:curl-7.73.0",

static_libraries = select({
    "@bazel_tools//src/conditions:windows": [
       "libcurl_imp.lib"
    ],

    # Linux
    "//conditions:default": []
}),

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [],

    # Linux
    "//conditions:default": ["libcurl.so"]
}),

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

visibility = ["//visibility:public"]
)
