
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def bzip2():
    maybe(
        new_git_repository,
        name = "bzip2",
        remote = "git://sourceware.org/git/bzip2.git",
        commit = "6a8690fc8d26c815e798c588f796eabe9d684cf0",
        build_file_content = """

filegroup(
    name = "bzip2_headers",
    srcs = glob(
        include = [
            "*.h"
        ]
    )
)

cc_library(
    name = "bzip2",
    srcs = glob(
        include = [
            ":bzip2_headers",
            "blocksort.c",
            "huffman.c",
            "crctable.c",
            "randtable.c",
            "compress.c",
            "decompress.c",
            "bzlib.c"
        ]
    ),
    hdrs = [
        ":bzip2_headers"
    ],
    includes = [
        "."
    ],

    visibility = ["//visibility:public"]
)
"""
    )
