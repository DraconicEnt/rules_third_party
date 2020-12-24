load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Build config pulled from CMakeLists.txt


def bzip2():
    maybe(
        http_archive,
        name = "bzip2",
        url = "https://www.sourceware.org/pub/bzip2/bzip2-latest.tar.gz",
        build_file_content = """

filegroup(
    name = "bzip2_headers",
    srcs = glob(
        include = [
            "bzip2-1.0.8/*.h"
        ]
    )
)

cc_library(
    name = "bzip2",
    srcs = glob(
        include = [
            ":bzip2_headers",
            "bzip2-1.0.8/blocksort.c",
            "bzip2-1.0.8/huffman.c",
            "bzip2-1.0.8/crctable.c",
            "bzip2-1.0.8/randtable.c",
            "bzip2-1.0.8/compress.c",
            "bzip2-1.0.8/decompress.c",
            "bzip2-1.0.8/bzlib.c"
        ]
    ),
    hdrs = [
        ":bzip2_headers"
    ],
    includes = [
        "bzip2-1.0.8"
    ],

    visibility = ["//visibility:public"]
)
"""
    )
