load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def lzma():
    maybe(
        http_archive,
        name = "lzma",
        sha256 = "f6f4910fd033078738bd82bfba4f49219d03b17eb0794eb91efbae419f4aba10",
        url = "https://iweb.dl.sourceforge.net/project/lzmautils/xz-5.2.5.tar.gz",
        build_file = "@rules_third_party//:lzma.BUILD"
    )
