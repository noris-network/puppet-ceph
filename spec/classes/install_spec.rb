require 'spec_helper'
describe 'ceph::install' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  context 'with defaults for all parameters' do
    let(:pre_condition) { 'class{"ceph": mon_hosts => ["x"], release => "x" }' }
    it { should contain_apt__source('ceph').with_release('wheezy') }
  end
  context 'with os_release set to foobar' do
    let(:pre_condition) { 'class{"ceph": os_release => "foobar", mon_hosts => ["x"], release => "x" }' }
    it { should contain_apt__source('ceph').with_release('foobar') }
  end
end
