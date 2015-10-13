require 'spec_helper'
describe 'ceph::config' do
  let(:facts) { { 'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let(:pre_condition) { 'class {"ceph": mon_hosts => [ "foo", "bar" ], release => "firefly", cluster_net => "1.2.3.4/24", public_net => "5.6.7.8/24" }' }
  it { should contain_class('ceph::config') }
  it { should contain_file('/etc/ceph').with_ensure('directory') }
  it { should contain_concat('/etc/ceph/ceph.conf') }
  it { should contain_concat('/etc/ceph/keyring') }
  it { should contain_concat__fragment('ceph-main').with_content(/^mon host = foo, bar$/) }
  it { should contain_concat__fragment('ceph-main').with_content(/^cluster network = 1.2.3.4\/24$/) }
  it { should contain_concat__fragment('ceph-main').with_content(/^public network = 5.6.7.8\/24$/) }
  it { should contain_concat('/etc/ceph/rbdmap') }
  it { should contain_concat__fragment('/etc/ceph/rbdmap-head')}
end
