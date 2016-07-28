require 'spec_helper'
describe 'ceph::key', :type => :define do
  let(:facts) { {:concat_basedir => '/dne', :osfamily => 'Debian'} }
  let(:params) { { :key => 'blafoo' } }
  context 'with foo client' do
    let(:title) { 'client.foo' }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.foo').with_content(/key = blafoo$/) }
  end
  context 'with admin client' do
    let(:title) { 'client.admin' }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.admin').with_content(/key = blafoo$/) }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.admin').with_content(/auid = 0$/) }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.admin').with_content(/caps mds = "allow"$/) }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.admin').with_content(/caps mon = "allow \*"$/) }
    it { should contain_concat__fragment('/etc/ceph/keyring-client.admin').with_content(/caps osd = "allow \*"$/) }
  end
end
