# frozen_string_literal: true

resource_name :openssl_installation
provides :openssl_installation

default_action :create

property :version, String, required: true
property :install_directory, String, name_property: true
property :owner, String, default: 'root'
property :group, String, default: 'root'

action :create do
  create_openssl_install(@new_resource)
end

action_class do
  include OpenSslInstall::Helper
end
