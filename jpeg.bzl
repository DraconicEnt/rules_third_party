load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Build config pulled from CMakeLists.txt


def jpeg():
    maybe(
        http_archive,
        name = "jpeg",
        sha256 = "75c3ec241e9996504fe02a9ed4d12f16b74ade713972f3db9e65ce95cd27e35d",
        url = "https://cfhcable.dl.sourceforge.net/project/libjpeg/libjpeg/6b/jpegsrc.v6b.tar.gz",
        build_file = "@rules_third_party//:jpeg.BUILD"
    )
