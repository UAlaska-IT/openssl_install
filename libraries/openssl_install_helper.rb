# frozen_string_literal: true

# This module implements helpers that are used for resources
module OpenSslInstall
  # This module exposes helpers to the client
  module Public
    def default_openssl_version
      return '1.1.1c'
    end

    def default_openssl_directory
      # Must match base_install
      return "opt/openssl/#{default_openssl_version}"
    end
  end
  # This module implements custom logic for this installer
  def Custom
  end
  # This module implements hooks into the base install
  def Hook
  end
  # This module implements helpers that are used for resources
  module Install
    # Hooks for install

    def base_name(_new_resource)
      return 'openssl'
    end

    def default_version(_new_resource)
      return default_openssl_version
    end

    def archive_file_name(new_resource)
      return "#{base_name(new_resource)}-#{new_resource.version}.tar.gz"
    end

    def download_base_url(new_resource)
      return 'https://www.openssl.org/source'
    end

    def archive_root_directory(new_resource)
      return "#{base_name(new_resource)}-#{new_resource.version}"
    end

    def extract_creates_file(_new_resource)
      return 'README'
    end

    def configuration_command(new_resource)
      code = './config shared'
      code += " -Wl,-rpath=#{File.join(new_resource.install_directory, 'lib')}"
      code += ' no-ssl2 no-ssl3 no-weak-ssl-ciphers' if new_resource.strict_security
      code += " --prefix=#{new_resource.install_directory}"
      code += " --openssldir=#{new_resource.install_directory}"
      return code
    end

    def install_creates_file(_new_resource)
      return 'bin/openssl'
    end

    def install_command(_new_resource)
      return 'make install'
    end

    def post_install_logic(_new_resource)
      # Call custom logic here
    end

    # For common install code see base_install cookbook
  end
end

Chef::Provider.include(OpenSslInstall::Public)
Chef::Recipe.include(OpenSslInstall::Public)
Chef::Resource.include(OpenSslInstall::Public)
