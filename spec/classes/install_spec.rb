require 'spec_helper'
describe 'ceph::install' do
  let(:facts) { { 'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let(:pre_condition) { 'class {"ceph": mon_hosts => [ "foo", "bar" ], release => "firefly" }' }
  it { should contain_class('ceph::install') }
  it { should contain_apt__source('ceph').with_location("http://ceph.com/debian-firefly/") }
  it { should contain_package('ceph').with_ensure('installed') }
end
