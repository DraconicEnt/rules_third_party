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

load("//applications:graphviz.bzl", "run_graphviz")

exports_files([
    "pnglibconf.h",
    "allegro.BUILD",
    "bullet.BUILD",
    "bzip2.BUILD",
    "curl.BUILD",
    "enet.BUILD",
    "freetype.BUILD",
    "graphviz.BUILD",
    "harfbuzz.BUILD",
    "iconv.BUILD",
    "irrlicht.BUILD",
    "jpeg.BUILD",
    "lzma.BUILD",
    "physfs.BUILD"
])

genquery(
    name = "irrlicht_dependencies_diagram",
    opts = [
        "--output",
        "graph"
    ],
    expression = "deps(@irrlicht//:irrlicht)",
    scope = ["@irrlicht//:irrlicht"],
)

run_graphviz(
    name = "irrlicht_dependency_diagram_png",
    input = ":irrlicht_dependencies_diagram",
    output = "irrlicht_dependencies.png"
)
