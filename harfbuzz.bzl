load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def harfbuzz():
    maybe(
        new_git_repository,
        name = "harfbuzz",
        remote = "https://github.com/harfbuzz/harfbuzz.git",
        shallow_since = "1598654382 +0200",
        # Tag 2.7.2
        commit = "9c98b2b9a9e43669c5e2b37eaa41b1e07de1ede3",
        build_file = "@rules_third_party//:harfbuzz.BUILD"
    )
