require 'spec_helper'
describe 'ceph::config' do
  let(:facts) { { 'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let(:pre_condition) { 'class {"::ceph": mon_hosts => ["foo","bar"] }' }
  it { should contain_class('ceph::config') }
  it { should contain_file('/etc/ceph').with_ensure('directory') }
  it { should contain_concat('/etc/ceph/ceph.conf') }
  it { should contain_concat('/etc/ceph/keyring') }
  it { should contain_concat__fragment('/etc/ceph/keyring-head')}
  it { should contain_concat('/etc/ceph/rbdmap') }
  it { should contain_concat__fragment('/etc/ceph/rbdmap-head')}
end