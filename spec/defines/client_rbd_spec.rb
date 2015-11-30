require 'spec_helper'
describe 'ceph::client::rbd', :type => :define do
  let(:facts) { {:concat_basedir => '/dne', :osfamily => 'Debian'} }
  let(:title) { 'test' }
  context 'with defaults for all parameters' do
    it { should contain_concat__fragment('/etc/ceph/rbdmap-test').with_content(/^rbd\/test\s+id=admin,keyring=\/etc\/ceph\/keyring$/) }
    it { should contain_exec('map-rbd-test').with_command("rbd -p rbd --id admin map test") }
  end
end
