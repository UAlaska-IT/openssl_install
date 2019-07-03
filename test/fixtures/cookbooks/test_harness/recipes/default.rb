# frozen_string_literal: true

include_recipe 'openssl_install::default'

openssl_installation 'All Defaults'

directory '/usr/local/openssl-dl'

directory '/usr/local/openssl-bld'

directory '/usr/local/openssl'

user 'bud'

openssl_installation 'No Defaults' do
  version '1.0.2s'
  download_directory '/usr/local/openssl-dl'
  build_directory '/usr/local/openssl-bld'
  install_directory '/usr/local/openssl'
  owner 'bud'
  group 'bud'
  strict_security false
end
