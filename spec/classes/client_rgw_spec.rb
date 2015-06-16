require 'spec_helper'
describe 'ceph::client::rgw' do

  context 'with defaults for all parameters' do
    it { should contain_class('ceph::client::rgw') }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^\[client.radosgw.rgw\]$/) }
    let(:facts) { {'hostname' => 'rgw', :concat_basedir => '/dne'} }
    let(:params) { { 'rgw_dns_name' => 'rgw.example.com' } }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^host = rgw$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^rgw dns name = rgw.example.com$/) }
    it { should contain_package('radosgw').with_ensure('installed') }
    it { should contain_service('radosgw').with_ensure('running') }
  end
end
