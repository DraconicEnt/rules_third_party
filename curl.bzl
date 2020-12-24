load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def curl():
    # Load CURL
    maybe(
        http_archive,
        name = "curl",
        urls = [
            "https://curl.se/download/curl-7.73.0.tar.gz"
        ],
        sha256 = "ba98332752257b47b9dea6d8c0ad25ec1745c20424f1dd3ff2c99ab59e97cf91",
        build_file_content = """
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
        """
    )
