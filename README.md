# OpenSSL Install Cookbook

[![License](https://img.shields.io/github/license/ualaska-it/openssl_install.svg)](https://github.com/ualaska-it/openssl_install)
[![GitHub Tag](https://img.shields.io/github/tag/ualaska-it/openssl_install.svg)](https://github.com/ualaska-it/openssl_install)
[![Build status](https://ci.appveyor.com/api/projects/status/hqu2xohgdgi1b0wx/branch/master?svg=true)](https://ci.appveyor.com/project/UAlaska/checksum-file/branch/master)
[![codecov](https://codecov.io/gh/UAlaska-IT/openssl_install/branch/master/graph/badge.svg)](https://codecov.io/gh/UAlaska-IT/openssl_install)

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose

This cookbook provides a single resource that downloads, configures, compiles, and installs OpenSSL.

## Requirements

### Chef

This cookbook requires Chef 14+

### Platforms

Supported Platform Families:

* Debian
  * Ubuntu, Mint
* Red Hat Enterprise Linux
  * Amazon, CentOS, Oracle
* Suse

Platforms validated via Test Kitchen:

* Ubuntu
* Debian
* CentOS
* Oracle
* Fedora
* Amazon
* Suse

Notes:

* This cookbook should support any recent Linux variant.

### Dependencies

This cookbook does not constrain its dependencies because it is intended as a utility library.
It should ultimately be used within a wrapper cookbook.

## Resources

This cookbook provides one resource for creating an OpenSSL installation.

### openssl_installation


## Recipes

This cookbook provides no recipes.

## Examples

Custom resources can be used as below.

```ruby
openssl_installation 'No Defaults' do
  version '1.1.0k'
  download_directory '/usr/local/openssl-dl'
  build_directory '/usr/local/openssl-bld'
  install_directory '/usr/local/openssl'
  owner 'some-dudette'
  group 'some-dudettes'
  strict_security false
end
```

## Development

See CONTRIBUTING.md and TESTING.md.
