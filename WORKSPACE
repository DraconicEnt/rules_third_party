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

load("//libraries:enet.bzl", "enet")
load("//libraries:osg.bzl", "osg")
load("//libraries:tiff.bzl", "tiff")
load("//libraries:zlib.bzl", "zlib")
load("//libraries:png.bzl", "png")
load("//libraries:freetype.bzl", "freetype")
load("//libraries:allegro.bzl", "allegro")
load("//libraries:curl.bzl", "curl")
load("//libraries:sdl2_image.bzl", "sdl2_image")
load("//libraries:sdl2_image_prebuilt.bzl", "sdl2_image_prebuilt")
# load("//:sdl2.bzl", "sdl2")
load("//libraries:mygui.bzl", "mygui")
load("//libraries:bullet.bzl", "bullet")
load("//libraries:physfs.bzl", "physfs")
load("//libraries:xml2.bzl", "xml2")
load("//libraries:iconv.bzl", "iconv")
load("//libraries:lzma.bzl", "lzma")
load("//applications:doxygen.bzl", "doxygen")
load("//applications:graphviz.bzl", "graphviz")
load("//libraries:harfbuzz.bzl", "harfbuzz")
load("//libraries:irrlicht.bzl", "irrlicht")
load("//libraries:jpeg.bzl", "jpeg")
load("//libraries:bzip2.bzl", "bzip2")
load("//libraries:python3.bzl", "python3")
load("//libraries:lua.bzl", "lua")
load("//applications:bison.bzl", "bison")

# FIXME: Is there a way to reference ie. COSOperator without having to do this in the local builds?
local_repository(
    name = "rules_third_party",
    path = "."
)

maybe(
    http_archive,
    name = "rules_foreign_cc",
    sha256 = "d54742ffbdc6924f222d2179f0e10e911c5c659c4ae74158e9fe827aad862ac6",
    strip_prefix = "rules_foreign_cc-0.2.0",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.2.0.tar.gz"
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
rules_foreign_cc_dependencies()

# Initialize libraries
enet()
bullet()
allegro()
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
python3()
lua()
