require 'spec_helper'
describe 'ceph' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let (:params) { { :mon_hosts => ['foo','bar'], :release => 'firefly' }}
  it { should contain_class('ceph') }
end

at_exit { RSpec::Puppet::Coverage.report! }
