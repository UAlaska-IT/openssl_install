# frozen_string_literal: true

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

describe package('gcc') do
  it { should be_installed }
end

describe package('g++') do
  it { should be_installed } if node['platform_family'] == 'debian'
end

describe package('gcc-c++') do
  it { should be_installed } unless node['platform_family'] == 'debian'
end

describe package('make') do
  it { should be_installed }
end

describe file('/usr/local/openssl-dl') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl-bld') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe user('bud') do
  it { should exist }
  its('group') { should eq 'bud' }
  its('groups') { should eq ['bud'] }
  its('home') { should eq '/home/bud' }
  its('shell') { should eq '/bin/sh' }
end

# Begin white-box testing of resources

describe file('/var/chef') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache/openssl-1.1.1c.tar.gz') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl-dl/openssl-1.1.0k.tar.gz') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file('/var/chef/cache/openssl-1.1.1c') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl-bld/openssl-1.1.0k') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file('/var/chef/cache/openssl-1.1.1c-dl-checksum') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache/openssl-1.1.0k-dl-checksum') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache/openssl-1.1.1c-src-checksum') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache/openssl-1.1.0k-src-checksum') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/chef/cache/openssl-1.1.1c/README') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o664 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl-bld/openssl-1.1.0k/README') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o664 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file('/opt/openssl/1.1.1c') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/local/openssl') do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end
