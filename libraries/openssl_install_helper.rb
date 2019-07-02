# frozen_string_literal: true

# This module implements helpers that are used for resources
module OpenSslInstall
  # This module implements helpers that are used for resources
  module Helper
    def openssl_download_url
      return "https://www.openssl.org/source/openssl-#{node[TCB]['openssl']['version']}.tar.gz"
    end

    def openssl_build_directory
      return File.join(node[TCB]['openssl']['source_root'], "openssl-#{node[TCB]['openssl']['version']}")
    end

    def openssl_install_directory
      return File.join(node[TCB]['openssl']['install_root'], node[TCB]['openssl']['version'])
    end

    def openssl_inc_directory
      return File.join(openssl_install_directory, 'include')
    end

    def openssl_lib_directory
      return File.join(openssl_install_directory, 'lib')
    end

    def create_openssl_install(new_resource)
    end
  end
end
