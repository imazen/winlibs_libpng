# libpng

Libpng is a dependency of the gd library

Original sources are from [http://www.libpng.org](http://www.libpng.org)

## Building for PHP

### Available prebuilt libraries

All prebuilt libraries are available as part of the [PHP
SDK](http://windows.php.net/downloads/php-sdk/)

### Requirements

- Zlib 1.2.7 sources
- Common tools used to compile PHP

### VC9/x86

- put zlib sources into ../../zlib
- open projects/vstudio2008/libpng.sln
- build the libpng project using "Lib Release" configuration
- build the libpng project using "Lib Debug" configuration

### VC11/x86/x64

- put zlib sources into ../../zlib-1.2.7
- open projects/vstudio2012/libpng.sln
- build the libpng project using "Release" or "Release Library" configuration
- build the libpng project using "Debug" or "Debug Library" configuration

### Appveyor builds
Current master:

[![Build status](https://ci.appveyor.com/api/projects/status/2ifs8txm9ltwmfsd/branch/master)](https://ci.appveyor.com/project/imazen/libpng/branch/master)

Last build:

[![Build status](https://ci.appveyor.com/api/projects/status/2ifs8txm9ltwmfsd)](https://ci.appveyor.com/project/imazen/libpng)

### Drone.io build

[![Build Status](https://drone.io/github.com/imazen/libpng/status.png)](https://drone.io/github.com/imazen/libpng/latest)
