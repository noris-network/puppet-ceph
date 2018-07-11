require 'spec_helper'
describe 'ceph::service' do
  it { should contain_service('rbdmap').with( :ensure => 'running', :enable => true,) }
end

