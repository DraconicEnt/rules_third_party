load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def enet():
    # Load ENet
    maybe(
        http_archive,
        name = "enet",
        urls = [
            "https://github.com/lsalzman/enet/archive/v1.3.17.tar.gz"
        ],
        sha256 = "1e0b4bc0b7127a2d779dd7928f0b31830f5b3dcb7ec9588c5de70033e8d2434a",
        build_file = "@rules_third_party//:enet.BUILD"
    )
