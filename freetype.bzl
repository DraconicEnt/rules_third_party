load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def freetype():
    maybe(
        http_archive,
        name = "freetype",
        url = "https://download.savannah.gnu.org/releases/freetype/freetype-2.9.1.tar.gz",
        sha256 = "ec391504e55498adceb30baceebd147a6e963f636eb617424bcfc47a169898ce",
        build_file = "@rules_third_party//:freetype.BUILD"
    )
