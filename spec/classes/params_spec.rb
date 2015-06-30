require 'spec_helper'
describe 'ceph::params' do
  it { should contain_class('ceph::params') }
end
