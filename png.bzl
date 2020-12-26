load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//:zlib.bzl", "zlib")

def png():
    # Ensure dependencies are loaded
    zlib()

    maybe(
        http_archive,
        name = "png",
        sha256 = "505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca",
        url = "https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flibpng%2Ffiles%2Flibpng16%2F1.6.37%2Flibpng-1.6.37.tar.xz%2Fdownload&ts=1607941742",
        build_file = "@rules_third_party//:png.BUILD"
    )
