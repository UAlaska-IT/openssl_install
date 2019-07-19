# frozen_string_literal: true

node = json('/opt/chef/run_record/last_chef_run_node.json')['automatic']

base_name = 'openssl'
curr_ver = '1.1.1c'
prev_ver = '1.1.0k'

def archive_file(version)
  return "#{base_name}-#{version}.tar.gz"
end

def source_dir(version)
  return "#{base_name}-#{version}"
end

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

describe file("/usr/local/#{base_name}-dl") do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/usr/local/#{base_name}-bld") do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/usr/local/#{base_name}") do
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
  its('shell') { should eq '/bin/bash' }
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

describe file "/var/chef/cache/#{archive_file(curr_ver)}" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}-dl/#{archive_file(prev_ver)}" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file "/var/chef/cache/#{source_dir(curr_ver)}" do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}-bld/#{source_dir(prev_ver)}" do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o775 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file("/var/chef/cache/#{base_name}-#{curr_ver}-dl-checksum") do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/var/chef/cache/#{base_name}-#{prev_ver}-dl-checksum") do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/var/chef/cache/#{base_name}-#{curr_ver}-src-checksum") do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file("/var/chef/cache/#{base_name}-#{prev_ver}-src-checksum") do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/var/chef/cache/#{source_dir(curr_ver)}/README" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o664 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}-bld/#{source_dir(prev_ver)}/README" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o664 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file "/opt/#{base_name}" do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/opt/#{base_name}/#{curr_ver}" do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}" do
  it { should exist }
  it { should be_directory }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/var/chef/cache/#{source_dir(curr_ver)}/Makefile" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}-bld/#{source_dir(prev_ver)}/Makefile" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

# TODO: Tests for config entries

describe file "/opt/#{base_name}/#{curr_ver}/include/#{base_name}/#{base_name}conf.h" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}/include/#{base_name}/#{base_name}conf.h" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/opt/#{base_name}/#{curr_ver}/lib/libssl.so" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}/lib/libssl.so" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe file "/opt/#{base_name}/#{curr_ver}/bin/#{base_name}" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file "/usr/local/#{base_name}/bin/#{base_name}" do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o755 }
  it { should be_owned_by 'bud' }
  it { should be_grouped_into 'bud' }
end

describe bash "/opt/#{base_name}/#{curr_ver}/bin/#{base_name} version" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match(/1\.1\.1c/) }
end

describe bash "/usr/local/#{base_name}/bin/#{base_name} version" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match(/1\.1\.0k/) }
end

describe bash "/opt/#{base_name}/#{curr_ver}/bin/#{base_name} ciphers -v" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match(/TLSv1\.2/) }
  its(:stdout) { should_not match(/TLSv1\.1/) }
  its(:stdout) { should match(/TLSv1\s/) }
  its(:stdout) { should match(/SSLv3/) } # These are used by TLSv1
  its(:stdout) { should_not match(/SSLv2/) }
  its(:stdout) { should_not match(/SSLv1/) }
end

describe bash "/usr/local/#{base_name}/bin/#{base_name} ciphers -v" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq '' }
  its(:stdout) { should match(/TLSv1\.2/) }
  its(:stdout) { should_not match(/TLSv1\.1/) }
  its(:stdout) { should match(/TLSv1\s/) }
  its(:stdout) { should match(/SSLv3/) }
  its(:stdout) { should_not match(/SSLv2/) }
  its(:stdout) { should_not match(/SSLv1/) }
end
