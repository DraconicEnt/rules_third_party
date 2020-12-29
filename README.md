# Third-Party

![CI](https://github.com/DraconicEnt/Third-Party/workflows/CI/badge.svg?branch=develop)

Bazel resolved third party dependencies.
The purpose of this repository is to provide bazel-native (or tuned rules_foreign_cc definitions) for various third party repositories across Linux, Windows and MacOS.

## Why?

There is plenty of software that is generally useful that do not support the bazel build system. [rules_foreign_cc](https://github.com/bazelbuild/rules_foreign_cc)
addresses this problem only partially right now (and possibly won't ever fully address the problem with certain classes of build system Ie. configure/build) in that
it tends to have problems operating on platforms that aren't Linux. Sometimes it can be made to work, but sometimes assumptions are made about the build environment
that do not work well in bazel causing build failures.

Ultimately we want easy to access bazel libraries that work across at least Linux, Windows and MacOS.

## Usage

Add the following to your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

maybe(
    git_repository,
    name = "rules_third_party",
    remote = "https://github.com/DraconicEnt/rules_third_party.git",
    commit = "512b473cb80586381f6c14102cc6c8b0f118e0f7" # Change to any commit ID you want
)
```

To load and initialize a third party dependency (zlib here for example), also add the following to your WORKSPACE:

```starlark
load("@third_party//libraries:zlib.bzl", "zlib")

zlib()
```

For more information about supported libraries and their associated documentation, see [the wiki](https://github.com/DraconicEnt/rules_third_party/wiki).

### Using other Versions of Software

These rules are all defined using the maybe directive. This means you can load alternative versions of the software supported by this repository.
For example, you can load ENet 1.3.10 (instead of the 1.3.17) using the following code:

```starlark
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

maybe(
    http_archive,
    name = "enet",
    urls = [
        "https://github.com/lsalzman/enet/archive/v1.3.10.tar.gz"
    ],
    sha256 = "035f9b5cdc67b720a45952b77a28fdf054e93fd273df9dd7f6a3e13d60571069",
    build_file = "@rules_third_party//libraries:enet.BUILD"
)

# You should still load and call the initialization function, though, so that all subdependencies are initialized
# but only do this AFTER your declaration above.
load("@third_party//:libraries/enet.bzl", "enet")
enet()
```

### Assumptions

The following assumptions are made about your build environment:

* CMake is installed and in your PATH.
* Ninja is installed and in your PATH.
* Your build host is either Windows, Linux or MacOS.
