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
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

# https://github.com/lexxmark/winflexbison.git
def bison():
    maybe(
        http_archive,
        name = "bison",
        sha256 = "492ad61202de893ca21a99b621d63fa5389da58804ad79d3f226b8d04b803998",
        urls = [
            "https://mirrors.ocf.berkeley.edu/gnu/bison/bison-3.7.tar.gz",
            "https://gnu.askapache.com/bison/bison-3.7.tar.gz"
        ],
        strip_prefix = "bison-3.7",

        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:configure.bzl", "configure_make")

filegroup(
    name = "bison_files",
    srcs = glob(
        include=[
            "**/*"
        ]
    )
)

configure_make(
    name = "bison",
    lib_source = ":bison_files",
    binaries = [
        "bison",
        "yacc"
    ],
    static_libraries = [
        "liby.a"
    ],
    visibility = ["//visibility:public"]
)
        """
    )
