require 'spec_helper'
describe 'ceph' do
  let(:facts) { {'lsbdistcodename' => 'wheezy', 'osfamily' => 'debian', 'lsbdistid' => 'Debian', 'concat_basedir' => '/dne' } }
  let (:params) { {
    :mon_hosts => ['foo','bar'],
    :release => 'firefly',
    :cluster_net => '1.2.3.4/24',
    :public_net => '5.6.7.8/24',
    :osd_pool_default_crush_replicated_ruleset => 0,
    :osd_pool_default_size => 3,
    :osd_recovery_op_priority => 1,
    :osd_max_backfills => 1,
    :osd_recovery_max_active => 1,
    :config_dir_mode => '0750',
    :config_dir_group => 'nagios',
    :osd_heartbeat_grace => 60,
  }}
  it { should contain_class('ceph') }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^mon host\s+= foo, bar$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^cluster network\s+= 1.2.3.4\/24$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^public network\s+= 5.6.7.8\/24$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd pool default crush replicated ruleset\s+= 0$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd pool default size\s+= 3$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd recovery op priority\s+= 1$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd max backfills\s+= 1$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd recovery max active\s+= 1$/) }
  it { should contain_concat__fragment('/etc/ceph/ceph.conf-ceph-main').with_content(/^osd heartbeat grace\s+= 60$/) }

  it { should contain_file('/etc/ceph').with_group('nagios') }
  it { should contain_file('/etc/ceph').with_mode('0750') }
end

at_exit { RSpec::Puppet::Coverage.report! }
