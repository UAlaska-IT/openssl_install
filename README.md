# OpenSSL Install Cookbook

[![License](https://img.shields.io/github/license/ualaska-it/openssl_install.svg)](https://github.com/ualaska-it/openssl_install)
[![GitHub Tag](https://img.shields.io/github/tag/ualaska-it/openssl_install.svg)](https://github.com/ualaska-it/openssl_install)

__Maintainer: OIT Systems Engineering__ (<ua-oit-se@alaska.edu>)

## Purpose


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

* This cookbook should support any recent Windows or Linux variant.

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
