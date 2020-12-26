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
