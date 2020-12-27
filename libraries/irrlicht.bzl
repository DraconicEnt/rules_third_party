"""
    Copyright 2020 Robert MacGregor

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""

load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("//libraries:png.bzl", "png")
load("//libraries:jpeg.bzl", "jpeg")
load("//libraries:bzip2.bzl", "bzip2")

def irrlicht():
    # Ensure dependencies are loaded.
    png()
    jpeg()
    bzip2()

    maybe(
        http_archive,
        name = "irrlicht",
        patches = [
            "@rules_third_party//libraries:COSOperator.patch"
        ],
        urls = [
            "http://downloads.sourceforge.net/irrlicht/irrlicht-1.8.4.zip"
        ],
        sha256 = "f42b280bc608e545b820206fe2a999c55f290de5c7509a02bdbeeccc1bf9e433",

        build_file = "@rules_third_party//libraries:irrlicht.BUILD"
    )
