# Contributing

To contribute, you must file a pull request referencing your fork of this reposisitory. 
At this point the contribution will be reviewed and either merged or declined with comment or requests to change.

## Style & Structure

These are the main points of style / structure for code in this repository.

* Code generally should follow [PEP8](https://www.python.org/dev/peps/pep-0008/) where it makes sense to do so for Starlark.
* All libraries & applications listed in the compatability matrix in the main README must be proven to work in the CI.
* All libraries & applications should not rely on the system providing anything except system libraries you most definitely should have when building code. GCC runtime, X11 libraries, etc.
* All libraries & applications listed in the compatability matrix must use an external BUILD file (Ie. not build_file_contents). This is to support loading other versions of software than what this repository is rigged with.
* All libraries & applications listed in the compatability matrix must use maybe when declaring their repositories. This is to support loading other versions of software than what this repository is rigged with.
* All libraries & applications listed in the compatability matrix must also initialize their subdependencies using rules provided elsewhere in the repository.
