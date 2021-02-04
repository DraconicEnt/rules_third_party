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

load("@rules_foreign_cc//tools/build_defs:configure.bzl", "configure_make")

filegroup(
    name = "python3_files",
    srcs = glob(
        include=[
            "Python-3.9.1/**/*"
        ]
))

configure_make(
    name = "python3",
    lib_source = ":python3_files",

    make_commands = [
        "make -j$(nproc)",
        "make install"
    ],

    static_libraries = select({
        "@bazel_tools//src/conditions:windows": [
            "python3.9.lib"
        ],

        # Linux
        "//conditions:default": [
            "libpython3.9.a"
        ]
    }),

    configure_options = [
        # Python doesn't do quotations quite as intended, this will force macro redacted to expand to "redacted" in cases where this happens.
        "CFLAGS='-Dredacted=\"redacted\" -fPIC'",
        "CXXFLAGS='-Dredacted=\"redacted\" -fPIC'",
        "LDFLAGS='-fPIC'"
    ],

    visibility = ["//visibility:public"]
)
