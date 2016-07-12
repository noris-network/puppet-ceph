require 'spec_helper'
describe 'ceph::client::rgw' do

  context 'with defaults for all parameters' do
    it { should contain_class('ceph::client::rgw') }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^\[client.radosgw.rgw\]$/) }
    let(:facts) { {'hostname' => 'rgw', :concat_basedir => '/dne', :operatingsystemrelease => '8.1', :osfamily => 'Debian', :operatingsystem => 'Debian'} }
    let(:params) { {
      'rgw_dns_name'     => 'rgw.example.com',
      'rgw_bucket_index_max_shards' => '64'
    }}
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^host = rgw$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^rgw dns name = rgw.example.com$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-rgw').with_content(/^rgw override bucket index max shards = 64$/) }
    it { should contain_package('radosgw').with_ensure('installed') }
    it { should contain_service('radosgw').with_ensure('running') }
    it { should contain_class('apache') }
    it { should contain_class('apache::mod::auth_basic') }
    it { should contain_file('/var/www/fcgi').with_ensure('directory') }
  end
end
