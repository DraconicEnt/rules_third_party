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

load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

filegroup(
    name = "curl_sources",
    srcs = glob(
        include = [
            "curl-7.73.0/**/*"
        ]
    )
)

cmake(
    name = "curl",
    lib_source = ":curl_sources",

    out_static_libs = select({
        "@bazel_tools//src/conditions:windows": [
           "libcurl_imp.lib"
        ],

        # Linux
        "//conditions:default": []
    }),

    out_shared_libs = select({
        "@bazel_tools//src/conditions:windows": [],

        # Linux
        "//conditions:default": ["libcurl.so"]
    }),

    generate_crosstool_file = select({
        "@bazel_tools//src/conditions:windows": True,
        "//conditions:default": False
    }),

    generate_args = select({
       "@bazel_tools//src/conditions:windows": ["-GNinja"],
       "//conditions:default": None
    }),

    visibility = ["//visibility:public"]
)
