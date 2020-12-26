
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def bzip2():
    maybe(
        new_git_repository,
        name = "bzip2",
        remote = "git://sourceware.org/git/bzip2.git",
        commit = "6a8690fc8d26c815e798c588f796eabe9d684cf0",
        build_file = "@rules_third_party//:bzip2.BUILD"
    )
