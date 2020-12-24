# Third-Party

Bazel resolved third party dependencies. 
The purpose of this repository is to provide bazel-native (or tuned rules_foreign_cc definitions) for various third party repositories.

## Usage

Add the following to your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

maybe(
    git_repository,
    name = "third_party",
    remote = "git@github.com:DraconicEnt/Third-Party.git",
    commit = "512b473cb80586381f6c14102cc6c8b0f118e0f7" # Change to any commit ID you want
)
```

To load and initialize a third party dependency (zlib here for example), also add the following to your WORKSPACE:

```starlark
load("@third_party//:zlib.bzl", "zlib")

zlib()
```
