require 'spec_helper'
describe 'ceph::install' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  it { should contain_class('ceph::install') }
  context 'with defaults for all parameters' do
    let(:pre_condition) { 'class{"ceph": mon_hosts => ["x"]}' }
    it { should contain_package('ceph') }
  end
  context 'with release set to x and os_release set to foobar' do
    let(:pre_condition) { 'class{"ceph": os_release => "foobar", mon_hosts => ["x"], release => "x" }' }
    it { should contain_apt__source('ceph').with_release('foobar') }
    it { should contain_apt__source('ceph').with_location('http://ceph.com/debian-x/') }
    it { should contain_apt__pin('ceph').with_originator("RedHat") }
    it { should contain_apt__pin('ceph').with_packages("*") }
    it { should contain_apt__pin('ceph').with_priority("1001") }
  end
end
