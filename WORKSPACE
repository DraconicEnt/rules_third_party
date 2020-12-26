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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//:enet.bzl", "enet")
load("//:osg.bzl", "osg")
load("//:tiff.bzl", "tiff")
load("//:zlib.bzl", "zlib")
load("//:png.bzl", "png")
load("//:freetype.bzl", "freetype")
load("//:allegro.bzl", "allegro")
load("//:curl.bzl", "curl")
load("//:sdl2_image.bzl", "sdl2_image")
load("//:sdl2_image_prebuilt.bzl", "sdl2_image_prebuilt")
# load("//:sdl2.bzl", "sdl2")
load("//:mygui.bzl", "mygui")
load("//:bullet.bzl", "bullet")
load("//:physfs.bzl", "physfs")
load("//:xml2.bzl", "xml2")
load("//:iconv.bzl", "iconv")
load("//:lzma.bzl", "lzma")
load("//:doxygen.bzl", "doxygen")
load("//:graphviz.bzl", "graphviz")
load("//:harfbuzz.bzl", "harfbuzz")
load("//:irrlicht.bzl", "irrlicht")
load("//:jpeg.bzl", "jpeg")
load("//:bzip2.bzl", "bzip2")
load("//:bison.bzl", "bison")

# FIXME: Is there a way to reference ie. COSOperator without having to do this in the local builds?
local_repository(
    name = "rules_third_party",
    path = "."
)

maybe(
    http_archive,
    name = "rules_foreign_cc",
    strip_prefix = "rules_foreign_cc-master",
    sha256 = "3e6b0691fc57db8217d535393dcc2cf7c1d39fc87e9adb6e7d7bab1483915110",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/master.zip",
)
load("@rules_foreign_cc//:workspace_definitions.bzl", "rules_foreign_cc_dependencies")
rules_foreign_cc_dependencies()

# Initialize libraries
enet()
irrlicht()
lzma()
bzip2()
jpeg()
png()
curl()
harfbuzz()
graphviz()
bison()
freetype()
iconv()
tiff()
physfs()
xml2()
