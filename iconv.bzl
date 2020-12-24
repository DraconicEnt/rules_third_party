load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def iconv():
    maybe(
        http_archive,
        name = "iconv",
        urls = [
            "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.16.tar.gz"
        ],
        sha256 = "e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:configure.bzl", "configure_make")

cc_library(
    name = "iconv",
    srcs = glob(
        include = [
            "srclib/*.c",
            "srclib/*.h",
        ]
    ),
    visibility = ["//visibility:public"]
)
        """
    )
