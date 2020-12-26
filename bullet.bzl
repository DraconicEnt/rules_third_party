load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def bullet():
    # Load Bullet
    maybe(
        new_git_repository,
        name = "bullet",
        remote = "https://github.com/bulletphysics/bullet3.git",
        # Tag 3.0.7
        commit = "272c7099d3ba8ac9e8c142e361e8d4cf5d91b8f2",
        shallow_since = "1606325146 -0800",
        build_file = "@rules_third_party//:bullet.BUILD"
    )
