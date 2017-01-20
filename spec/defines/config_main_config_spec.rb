require 'spec_helper'
describe 'ceph::config::main_config', :type => :define do
  let(:facts) { { 'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let(:title) { '/etc/ceph/ceph.conf' }
  let(:params) { { 'mon_hosts' => [ 'mon01.ceph', 'mon02.ceph' ] } }
  it { should contain_concat('/etc/ceph/ceph.conf') }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^mon host = mon01.ceph, mon02.ceph/) }
end
