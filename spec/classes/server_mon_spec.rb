require 'spec_helper'
describe 'ceph::server::mon' do

  context 'with defaults for all parameters' do
    it { should contain_class('ceph::server::mon') }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^\[mon.1\]$/) }
    let(:facts) { {'hostname' => 'mon', 'ipaddress' => '1.2.3.4', 'osfamily' => 'Debian', :concat_basedir => '/dne', :fqdn => 'mon.ceph.com' } }
    let(:params) { { 'id' => 1, 'fsid' => 'a3782848-3584-4511-a1eb-2efde8296eb4' } }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^host = mon$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^mon addr = 1.2.3.4:6789$/) }
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-mon').with_content(/^public addr = 1.2.3.4$/) }

    it { should contain_exec('createmon-1').with_command("/usr/bin/ceph-mon --mkfs -i 1 --fsid a3782848-3584-4511-a1eb-2efde8296eb4 --keyring /etc/ceph/keyring") }
    it { should contain_exec('createmon-1').with_user("ceph") }
    it { should contain_file('/var/lib/ceph/mon/ceph-1').with_owner('ceph') }
    it { should contain_file('/var/lib/ceph/mon/ceph-1').with_group('ceph') }
    it { should contain_file('/var/lib/ceph/mon/ceph-1').with_ensure('directory') }

    it { should contain_host('mon.ceph.com').with_ip('1.2.3.4') }
    it { should contain_host('mon.ceph.com').with_host_aliases('mon') }

  end
end
