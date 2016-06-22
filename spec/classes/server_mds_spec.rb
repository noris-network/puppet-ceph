require 'spec_helper'
describe 'ceph::server::mds' do

  context 'with defaults for all parameters' do
    it { should contain_class('ceph::server::mds') }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mds').with_content(/^\[mds.1\]$/) }
    let(:facts) { {'hostname' => 'mds', 'ipaddress' => '1.2.3.4', 'osfamily' => 'Debian', :concat_basedir => '/dne' } }
    let(:params) { { 'id' => 1 } }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mds').with_content(/^host = mds$/) }
  end
end
