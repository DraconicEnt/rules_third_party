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

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

load("//:zlib.bzl", "zlib")
load("//:bison.bzl", "bison")
load("//:harfbuzz.bzl", "harfbuzz")

def graphviz():
    # Ensure dependencies are loaded
    zlib()
    harfbuzz()

    maybe(
        new_git_repository,
        name = "graphviz",
        remote = "https://gitlab.com/graphviz/graphviz.git",
        shallow_since = "1593420362 +0000",
        # Release 2.44.1
        commit = "771bc4dbff3e6f358fa75cdc7774a413ccacad51",
        build_file_content = """
load("@rules_foreign_cc//tools/build_defs:cmake.bzl", "cmake_external")

filegroup(
name = "graphviz_files",
srcs = glob(
    include=[
        "**/*"
    ]
)
)

cmake_external(
name = "graphviz",
lib_source = ":graphviz_files",

generate_crosstool_file = select({
    "@bazel_tools//src/conditions:windows": True,
    "//conditions:default": False
}),

cmake_options = select({
   "@bazel_tools//src/conditions:windows": ["-GNinja"],
   "//conditions:default": None
}),

make_commands = select({
   "@bazel_tools//src/conditions:windows": [
       "ninja",
       "ninja install"
   ],
   "//conditions:default": [
       "make -j$(nproc)",
       "make install",
       "cp plugin/core/*.so* graphviz/lib",
       "cp plugin/pango/*.so* graphviz/lib",
       "cp plugin/gd/*.so* graphviz/lib",
       "cp plugin/dot_layout/*.so* graphviz/lib",
       "cp plugin/neato_layout/*.so* graphviz/lib"
   ]
}),

shared_libraries = select({
    "@bazel_tools//src/conditions:windows": [

    ],

    # Linux
    "//conditions:default": [
        "libcdt.so",
        "libcdt.so.5",

        "libxdot.so.4.0.0",
        "libxdot.so",
        "libxdot.so.4",

        "libpathplan.so.4.0.0",
        "libpathplan.so",
        "libpathplan.so.4",
        "libcdt.so.5.0.0",

        "libcgraph.so.6",
        "libcgraph.so",
        "libcgraph.so.6.0.0",

        "libgvc.so",
        "libgvc.so.6",
        "libgvc.so.6.0.0",

        # Plugins
        "libgvplugin_pango.so",
        "libgvplugin_pango.so.6",
        "libgvplugin_pango.so.6.0.0",

        "libgvplugin_dot_layout.so",
        "libgvplugin_dot_layout.so.6",
        "libgvplugin_dot_layout.so.6.0.0",

        "libgvplugin_gd.so.6",
        "libgvplugin_gd.so.6.0.0",
        "libgvplugin_gd.so",

        "libgvplugin_core.so",
        "libgvplugin_core.so.6",
        "libgvplugin_core.so.6.0.0",

        "libgvplugin_neato_layout.so",
        "libgvplugin_neato_layout.so.6",
        "libgvplugin_neato_layout.so.6.0.0"
    ]
}),

binaries = select({
    "@bazel_tools//src/conditions:windows": [
        "dot.exe"
    ],

    # Linux
    "//conditions:default": [
        "dot"
    ]
}),

cache_entries = select({
    "@bazel_tools//src/conditions:windows": {
        "BISON_EXECUTABLE": "$EXT_BUILD_DEPS/bison_windows/bin/bison_windows.exe",
        "FLEX_EXECUTABLE": "$EXT_BUILD_DEPS/bison_windows/bin/flex_windows.exe"
    },

    # Linux
    "//conditions:default": {
        "CMAKE_CXX_FLAGS": "-I $EXT_BUILD_DEPS/harfbuzz/include/harfbuzz",
        "CMAKE_C_FLAGS": "-I $EXT_BUILD_DEPS/harfbuzz/include/harfbuzz",
        "BISON_EXECUTABLE": "$EXT_BUILD_DEPS/bison_linux/bin/bison"
    }
}),

deps = [
    "@zlib//:zlib",
    "@harfbuzz//:harfbuzz"
] + select({
    "@bazel_tools//src/conditions:windows": ["@bison_windows//:bison_windows", "@bison_windows//:flex_windows"],
    "//conditions:default": ["@bison_linux//:bison_linux"]
}),

visibility = ["//visibility:public"]
)
        """
    )

def run_graphviz(name, input, output, type="png"):
    native.genrule(
        name = name,
        srcs = [
            "@graphviz//:graphviz",
            input,
        ],
        outs = [
            output
        ],
        cmd = "\n".join([
            "DOT_BINARY=\"$(locations @graphviz//:graphviz)\"",

            # Load DOT binary location - the graphviz target is multiple objects and we're interested in the binary
            # TODO: Perhaps a filegroup to load the binaries?
            "IFS=' ' read -ra DOT_DATA <<< \"$$DOT_BINARY\"",
            "DOT_BINARY=$$(realpath $${DOT_DATA[1]})",
            "DOT_LIBS=\"$$(realpath $$(dirname $$DOT_BINARY)/../lib)\"",

            # Generate temporary directory for DOT data
            "DOT_TEMPORARY=$$(mktemp -d)",
            "cp $$DOT_LIBS/* $$DOT_TEMPORARY",

            # Set library path and GVBINDIR so that DOT runs correctly
            "export LD_LIBRARY_PATH=\"$$DOT_TEMPORARY\"",
            "export GVBINDIR=\"$$DOT_TEMPORARY\"",

            # Generate config file to ensure plugins are loaded by dot
            "$$DOT_BINARY -c",
            "$$DOT_BINARY -T%s $(location %s) > $@" % (type, input),

            # Cleanup
            "rm -rf $$DOT_TEMPORARY"
        ])
    )
