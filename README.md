# Third-Party

![CI](https://github.com/DraconicEnt/Third-Party/workflows/CI/badge.svg?branch=develop)

Bazel resolved third party dependencies.
The purpose of this repository is to provide bazel-native (or tuned rules_foreign_cc definitions) for various third party repositories.

## Support Matrix

The following targets support the following platforms:

| Library/Application    |   Import                                        | Target                |  Linux?  | Windows? |   OSX?   |
| ---------------------- | ----------------------------------------------- | --------------------  | -------- | -------- | -------- |
|        ZLib            | load("@third_party//:zlib.bzl", "zlib")         | @zlib//:zlib          | &#10003; | &#10003; | &#10007; |
|        PNG             | load("@third_party//:png.bzl", "png")           | @png//:png            | &#10007; | &#10007; | &#10007; |
|        Harfbuzz        | load("@third_party//:harfbuzz.bzl", "harfbuzz") | @harfbuzz//:harfbuzz  | &#10003; | &#10003; | &#10007; |
|        ENet            | load("@third_party//:enet.bzl", "enet")         | @enet//:enet          | &#10003; | &#10003; | &#10007; |
|        CURL            | load("@third_party//:curl.bzl", "curl")         | @curl//:curl          | &#10003; | &#10003; | &#10007; |
|        BZIP2           | load("@third_party//:bzip.bzl", "bzl")          | @bzip//:bzip          | &#10003; | &#10007; | &#10007; |
|        Irrlicht        | load("@third_party//:irrlicht.bzl", "irrlicht") | @irrlicht//:irrlicht  | &#10003; | &#10003; | &#10007; |
|        Freetype        | load("@third_party//:freetype.bzl", "freetype") | @freetype//:freetype  | &#10003; | &#10003; | &#10007; |
|         IConv          | load("@third_party//:iconv.bzl", "iconv")       | @iconv//:iconv        | &#10003; | &#10003; | &#10007; |
|         PhysFS         | load("@third_party//:physfs.bzl", "physfs")     | @physfs//:physfs      | &#10003; | &#10003; | &#10007; |
|         LZMA           | load("@third_party//:lzma.bzl", "lzma")         | @lzma//:lzma          | &#10003; | &#10003; | &#10007; |
|         TIFF           | load("@third_party//:tiff.bzl", "tiff")         | @tiff//:tiff          | &#10003; | &#10003; | &#10007; |
|         XML2           | load("@third_party//:xml2", "xml2")             | @xml2//:xml2          | &#10003; | &#10003; | &#10007; |

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
