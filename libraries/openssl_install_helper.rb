# frozen_string_literal: true

# This module implements helpers that are used for resources
module OpenSslInstall
  # This module implements helpers that are used for resources
  module Helper
    def openssl_download_url(version)
      return "https://www.openssl.org/source/openssl-#{version}.tar.gz"
    end

    def path_to_download_directory(given_directory)
      return given_directory if given_directory

      directory '/var/chef/cache'
      return '/var/chef/cache'
    end

    def path_to_download_file(given_path, version)
      directory = path_to_download_directory(given_path)
      return File.join(directory, "openssl-#{version}")
    end

    def path_to_build_directory(given_directory, version)
      return given_directory if given_directory

      directory '/var/chef/cache'
      return "/var/chef/cache/openssl-#{version}"
    end

    def openssl_install_directory(given_directory, version)
      return given_directory if given_directory

      return "/opt/openssl/#{version}"
    end

    def openssl_inc_directory(install_directory)
      return File.join(install_directory, 'include')
    end

    def openssl_lib_directory(install_directory)
      return File.join(install_directory, 'lib')
    end

    def download_archive(given_download_dir, version)
      download_file = path_to_download_file(given_download_dir, version)

      remote_file download_file do
        source openssl_download_url(year, version)
      end

      return download_file
    end

    def extract_archive(given_download_dir, build_directory, version, user, group)
      download_file = download_archive(given_download_dir, version)

      poise_archive download_file do
        destination build_directory
        user user
        group group
      end
    end

    def create_config_code(install_directory, strict_security)
      code = './config shared'
      code += ' no-ssl2 no-ssl3 no-weak-ssl-ciphers' if strict_security
      code += " --prefix=#{install_directory}"
      code += " --openssldir=#{install_directory}"
      return code
    end

    def configure_openssl(build_directory, install_directory, strict_security)
      code = create_config_code(install_directory, strict_security)
      bash 'Configure OpenSSL' do
        code code
        cwd build_directory
        creates 'Makefile'
      end
    end

    def compile_openssl(build_directory, install_directory)
      bash 'Compile OpenSSL' do
        code 'make && make install'
        cwd build_directory
        creates File.join(install_directory, 'bin/openssl')
      end
    end

    def create_openssl_install(new_resource)
      version = new_resource.version
      build_directory = path_to_build_directory(new_resource.build_directory, version)
      extract_archive(new_resource.download_directory, build_directory, version, new_resource.user, new_resource.group)
      install_directory = openssl_install_directory(new_resource.install_directory, version)
      configure_openssl(build_directory, install_directory, new_resource.strict_security)
      compile_openssl(build_directory, install_directory)
    end
  end
end
