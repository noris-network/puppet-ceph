require 'spec_helper'
describe 'ceph::server::mon' do

  context 'with defaults for all parameters' do
    it { should contain_class('ceph::server::mon') }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^\[mon.1\]$/) }
    let(:facts) { {'hostname' => 'mon', 'ipaddress' => '1.2.3.4', 'osfamily' => 'Debian', :concat_basedir => '/dne' } }
    let(:params) { { 'id' => 1 } }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^host = mon$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^mon addr = 1.2.3.4:6789$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^public addr = 1.2.3.4$/) }
  end
end

