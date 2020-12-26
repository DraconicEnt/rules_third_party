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
        build_file = "@rules_third_party//:curl.BUILD"
    )
