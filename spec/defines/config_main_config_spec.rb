require 'spec_helper'
describe 'ceph::config::main_config', :type => :define do
  let(:facts) { { 'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let(:title) { '/etc/ceph/ceph.conf' }
  let(:params) { {
    'mon_hosts' => [ 'mon01.ceph', 'mon02.ceph' ],
    'additional_options' => { "additional" => "option" },
    'mon_osd_min_down_reporters' => "30",
    'mon_osd_down_out_interval' => "86400"
  } }
  it { should contain_concat('/etc/ceph/ceph.conf') }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^mon host = mon01.ceph, mon02.ceph/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^additional = option/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^mon osd min down reporters = 30/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^mon osd down out interval = 86400/) }
end
