load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Build configuration pulled from zlib's CMakeLists.txt
"""
set(ZLIB_PUBLIC_HDRS
    ${CMAKE_CURRENT_BINARY_DIR}/zconf.h
    zlib.h
)
set(ZLIB_PRIVATE_HDRS
    crc32.h
    deflate.h
    gzguts.h
    inffast.h
    inffixed.h
    inflate.h
    inftrees.h
    trees.h
    zutil.h
)
set(ZLIB_SRCS
    adler32.c
    compress.c
    crc32.c
    deflate.c
    gzclose.c
    gzlib.c
    gzread.c
    gzwrite.c
    inflate.c
    infback.c
    inftrees.c
    inffast.c
    trees.c
    uncompr.c
    zutil.c
)
"""

def zlib():
    maybe(
        http_archive,
        name = "zlib",
        url = "https://zlib.net/zlib-1.2.11.tar.gz",
        sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        build_file_content = """
cc_library(
    name = "zlib",
    srcs = [
        # Public Headers
        "zlib-1.2.11/zconf.h",
        "zlib-1.2.11/zlib.h",

        # Private Headers
        "zlib-1.2.11/crc32.h",
        "zlib-1.2.11/deflate.h",
        "zlib-1.2.11/gzguts.h",
        "zlib-1.2.11/inffast.h",
        "zlib-1.2.11/inffixed.h",
        "zlib-1.2.11/inflate.h",
        "zlib-1.2.11/inftrees.h",
        "zlib-1.2.11/trees.h",
        "zlib-1.2.11/zutil.h",

        # Source Code
        "zlib-1.2.11/adler32.c",
        "zlib-1.2.11/compress.c",
        "zlib-1.2.11/crc32.c",
        "zlib-1.2.11/deflate.c",
        "zlib-1.2.11/gzclose.c",
        "zlib-1.2.11/gzlib.c",
        "zlib-1.2.11/gzread.c",
        "zlib-1.2.11/gzwrite.c",
        "zlib-1.2.11/inflate.c",
        "zlib-1.2.11/infback.c",
        "zlib-1.2.11/inftrees.c",
        "zlib-1.2.11/inffast.c",
        "zlib-1.2.11/trees.c",
        "zlib-1.2.11/uncompr.c",
        "zlib-1.2.11/zutil.c"
    ],

    visibility = ["//visibility:public"]
)
        """
    )
