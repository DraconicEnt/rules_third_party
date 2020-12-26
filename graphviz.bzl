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
        build_file = "@rules_third_party//:graphviz.BUILD"
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
