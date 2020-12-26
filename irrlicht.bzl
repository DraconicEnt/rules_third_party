load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# load("//:png.bzl", "png")
# load("//:jpeg.bzl", "jpeg")
# load("//:bzip2.bzl", "bzip2")

def irrlicht():
    # Ensure dependencies are loaded.
#    png()
#    jpeg()
#    bzip2()

    maybe(
        http_archive,
        name = "irrlicht",
        patches = [
            "@rules_third_party//:COSOperator.patch"
        ],
        urls = [
            "http://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip"
        ],
        sha256 = "f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433",

        build_file = "@rules_third_party//:irrlicht.BUILD"
    )
