# frozen_string_literal: true

# This module implements helpers that are used for resources
module OpenSslInstall
  # This module implements helpers that are used for resources
  module Helper
    BASE_NAME = 'openssl'

    def path_to_download_directory(given_directory)
      return given_directory if given_directory

      directory '/var/chef'
      directory '/var/chef/cache'
      return '/var/chef/cache'
    end

    def archive_file_name(version)
      return "#{BASE_NAME}-#{version}.tar.gz"
    end

    def path_to_download_file(given_directory, version)
      directory = path_to_download_directory(given_directory)
      file = File.join(directory, archive_file_name(version))
      return file
    end

    def download_url(version)
      return "https://www.openssl.org/source/#{archive_file_name(version)}"
    end

    def download_archive(given_download_dir, version)
      download_file = path_to_download_file(given_download_dir, version)
      url = download_url(version)
      remote_file download_file do
        source url
      end
      return download_file
    end

    def path_to_build_directory(given_directory, version)
      return given_directory if given_directory

      directory '/var/chef'
      directory '/var/chef/cache'
      return "/var/chef/cache/#{BASE_NAME}-#{version}"
    end

    def extract_archive(new_resource, build_directory, version)
      download_file = download_archive(new_resource.download_directory, version)
      poise_archive download_file do
        destination build_directory
        user new_resource.owner
        group new_resource.group
      end
    end

    def path_to_install_directory(given_directory, version)
      return given_directory if given_directory

      directory "/opt/#{BASE_NAME}"
      directory "/opt/#{BASE_NAME}/#{version}"
      return "/opt/#{BASE_NAME}/#{version}"
    end

    def create_config_code(install_directory, strict_security)
      code = './config shared'
      code += ' no-ssl2 no-ssl3 no-weak-ssl-ciphers' if strict_security
      code += " --prefix=#{install_directory}"
      code += " --openssldir=#{install_directory}"
      return code
    end

    def configure_build(build_directory, install_directory, strict_security)
      code = create_config_code(install_directory, strict_security)
      bash 'Configure Build' do
        code code
        cwd build_directory
        creates File.join(build_directory, 'Makefile')
      end
    end

    def check_build_directory(build_directory, version)
      checksum_file 'Source Checksum' do
        source_path build_directory
        target_path "/var/chef/cache/#{BASE_NAME}-#{version}-checksum"
      end
    end

    def manage_bin_file(bin_file)
      file bin_file do
        action :nothing
        manage_symlink_source false
        subscribes :delete, 'checksum_file[Source Checksum]', :immediate
      end
    end

    def make_build(build_directory, bin_file)
      bash 'Compile and Install' do
        code 'make && make install'
        cwd build_directory
        creates bin_file
      end
    end

    def compile_and_install(build_directory, install_directory, version)
      check_build_directory(build_directory, version)
      bin_file = File.join(install_directory, 'bin/openssl')
      manage_bin_file(bin_file)
      make_build(build_directory, bin_file)
    end

    def build_binary(build_directory, given_install_directory, version, strict_security)
      install_directory = path_to_install_directory(given_install_directory, version)
      configure_build(build_directory, install_directory, strict_security)
      compile_and_install(build_directory, install_directory, version)
    end

    def create_install(new_resource)
      version = new_resource.version
      build_directory = path_to_build_directory(new_resource.build_directory, version)
      extract_archive(new_resource, build_directory, version)
      build_binary(build_directory, new_resource.install_directory, version, new_resource.strict_security)
    end
  end
end
