# Third-Party

![CI](https://github.com/DraconicEnt/Third-Party/workflows/CI/badge.svg?branch=develop)

Bazel resolved third party dependencies.
The purpose of this repository is to provide bazel-native (or tuned rules_foreign_cc definitions) for various third party repositories.

## Support Matrix

The following targets support the following platforms:

| Library/Application    |    Versions   | Import                                          | Target                |  Linux?  | Windows? |   OSX?   |
| ---------------------- | ------------- | ----------------------------------------------- | --------------------  | -------- | -------- | -------- |
|        ZLib            |    1.2.11     | load("@third_party//:zlib.bzl", "zlib")         | @zlib//:zlib          | &#10003; | &#10003; | &#10007; |
|        PNG             |    1.6.37     | load("@third_party//:png.bzl", "png")           | @png//:png            | &#10007; | &#10007; | &#10007; |
|        Harfbuzz        |    2.7.2      | load("@third_party//:harfbuzz.bzl", "harfbuzz") | @harfbuzz//:harfbuzz  | &#10003; | &#10003; | &#10003; |
|        ENet            |    1.3.17     | load("@third_party//:enet.bzl", "enet")         | @enet//:enet          | &#10003; | &#10003; | &#10003; |
|        CURL            |    7.73.0     | load("@third_party//:curl.bzl", "curl")         | @curl//:curl          | &#10003; | &#10003; | &#10007; |
|        BZIP2           |               | load("@third_party//:bzip.bzl", "bzl")          | @bzip//:bzip          | &#10003; | &#10007; | &#10007; |
|        Irrlicht        |    1.8.4      | load("@third_party//:irrlicht.bzl", "irrlicht") | @irrlicht//:irrlicht  | &#10003; | &#10003; | &#10007; |
|        Freetype        |    2.9.1      | load("@third_party//:freetype.bzl", "freetype") | @freetype//:freetype  | &#10003; | &#10003; | &#10007; |
|         IConv          |    1.16       | load("@third_party//:iconv.bzl", "iconv")       | @iconv//:iconv        | &#10003; | &#10003; | &#10003; |
|         PhysFS         |    3.0.2      | load("@third_party//:physfs.bzl", "physfs")     | @physfs//:physfs      | &#10003; | &#10003; | &#10007; |
|         LZMA           |    5.2.5      | load("@third_party//:lzma.bzl", "lzma")         | @lzma//:lzma          | &#10003; | &#10003; | &#10003; |
|         TIFF           |    4.1.0      | load("@third_party//:tiff.bzl", "tiff")         | @tiff//:tiff          | &#10003; | &#10003; | &#10007; |
|         XML2           |               | load("@third_party//:xml2", "xml2")             | @xml2//:xml2          | &#10003; | &#10003; | &#10007; |

## Build Configurations

Some items support configurations specified on the bazel command line. They are listed below.

### Irrlicht

#### irrlicht_d3d8

Used to request that D3D8 support is not compiled. May be used by:

```bash
bazel build @irrlicht//:irrlicht --define irrlicht_d3d8=disabled
```

If set to disabled, ```NO_IRR_COMPILE_WITH_DIRECT3D_8_``` is passed as a define when compiling. If not specified,
Irrlicht default behavior is used.

#### irrlicht_d3d9

Used to request that D3D9 support is not compiled. May be used by:

```bash
bazel build @irrlicht//:irrlicht --define irrlicht_d3d9=disabled
```

If set to disabled, ```NO_IRR_COMPILE_WITH_DIRECT3D_9_``` is passed as a define when compiling. If not specified,
Irrlicht default behavior is used.

#### irrlicht_opengl

Used to request that OpenGL support is not compiled. May be used by:

```bash
bazel build @irrlicht//:irrlicht --define irrlicht_opengl=disabled
```

If set to disabled, ```NO_IRR_COMPILE_WITH_OPENGL_``` is passed as a define when compiling. If not specified,
Irrlicht default behavior is used.

#### irrlicht_software

Used to request that software render support is not compiled. May be used by:

```bash
bazel build @irrlicht//:irrlicht --define irrlicht_software=disabled
```

If set to disabled, ```NO_IRR_COMPILE_WITH_SOFTWARE_``` is passed as a define when compiling. If not specified,
Irrlicht default behavior is used.

#### irrlicht_burnings

Used to request that burnings video render support is not compiled. May be used by:

```bash
bazel build @irrlicht//:irrlicht --define irrlicht_burnings=disabled
```

If set to disabled, ```NO_IRR_COMPILE_WITH_BURNINGSVIDEO_``` is passed as a define when compiling. If not specified,
Irrlicht default behavior is used.

## Usage

Add the following to your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

maybe(
    git_repository,
    name = "rules_third_party",
    remote = "git@github.com:DraconicEnt/Third-Party.git",
    commit = "512b473cb80586381f6c14102cc6c8b0f118e0f7" # Change to any commit ID you want
)
```

To load and initialize a third party dependency (zlib here for example), also add the following to your WORKSPACE:

```starlark
load("@rules_third_party//:zlib.bzl", "zlib")

zlib()
```

### Change Software Version

All software declared as supported by at least one platform should be setup with an independent BUILD file to allow for changing out software versions that are compatible
with the BUILD file. An example of how to do this with ENet to load ENet v1.3.10 instead of of 1.3.17 is below.

```starlark
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

maybe(
    http_archive,
    name = "enet",
    urls = [
        "https://github.com/lsalzman/enet/archive/v1.3.10.tar.gz"
    ],
    sha256 = "035f9b5cdc67b720a45952b77a28fdf054e93fd273df9dd7f6a3e13d60571069",
    build_file = "@rules_third_party//:enet.BUILD"
)
```

This works because all software marked as supported are declared using the 'maybe' directive, allowing them to be overridden with alternative software versions. It is still recommended to call
the initialization function for software you override (but only AFTER your override) to ensure that any subdependencies are loaded if there are any.
