require 'spec_helper'
describe 'ceph::install' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne', 'os' => { 'name' => 'Debian', "release" => { "full" => "9.0", "major" => "9" } } } }
  context 'with defaults for all parameters' do
    let(:pre_condition) { 'class{"ceph": mon_hosts => ["x"]}' }
    it { should contain_class('ceph::install') }
    it { should contain_package('ceph') }
    it { should contain_service('rbdmap').with( :ensure => 'running', :enable => true,) }
  end
  context 'with release set to x and os_release set to foobar' do
    let(:pre_condition) { 'class{"ceph": os_release => "foobar", mon_hosts => ["x"], release => "x" }' }
    it { should contain_apt__source('ceph').with_release('foobar') }
    it { should contain_apt__source('ceph').with_location('http://download.ceph.com/debian-x/') }
    it { should contain_apt__pin('ceph').with_originator("RedHat") }
    it { should contain_apt__pin('ceph').with_packages("*") }
    it { should contain_apt__pin('ceph').with_priority("1001") }
  end

  context 'with repo_url set too http://foobar/deb/jewel' do
    let(:pre_condition) { 'class{"ceph": mon_hosts => ["x"], repo_url => "http://foobar/deb/jewel" }' }
    it { should contain_apt__source('ceph').with_location('http://foobar/deb/jewel') }
  end
end
