load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def xml2():
    # Load Bullet
    maybe(
        new_git_repository,
        name = "xml2",
        remote = "https://gitlab.gnome.org/GNOME/libxml2.git",
        shallow_since = "1608131527 +0100",
        commit = "a67b63d183f5ab5d5af70fe47ef3a3d53fa3cb09",
        build_file = "@rules_third_party//:xml2.BUILD"
    )
