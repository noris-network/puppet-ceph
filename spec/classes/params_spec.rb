require 'spec_helper'
describe 'ceph::params' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne', :os => { :name => 'Debian', "release" => { "full" => "9.0" } } } }
  it { should contain_class('ceph::params') }
end
