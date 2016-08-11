require 'spec_helper'
describe 'ceph::server::osd', :type => :define do
  let(:facts) { {:concat_basedir => '/dne', :osfamily => 'Debian'} }
  let(:title) { '47' }
  let(:params) { {:journal => '/dev/sdb1', :data => '/dev/sdc' } }
  context 'with defaults for all parameters' do
    it { should contain_concat__fragment('/etc/ceph/ceph.conf-osd-47').with_content(/^\[osd\.47\]/) }
    it { should contain_exec('createosd-47').with_command("/usr/bin/ceph-osd -i 47 --mkfs --mkkey --osd-journal /dev/sdb1 && /usr/bin/ceph auth add osd.47 osd 'allow *' mon 'allow rwx' -i /var/lib/ceph/osd/ceph-47/keyring") }
    it { should contain_exec('createosd-47').with_user("ceph") }
    it { should contain_file('/var/lib/ceph/osd/ceph-47').with_owner('ceph') }
    it { should contain_file('/var/lib/ceph/osd/ceph-47').with_group('ceph') }
    it { should contain_file('/var/lib/ceph/osd/ceph-47').with_ensure('directory') }

    it { should contain_mount('/var/lib/ceph/osd/ceph-47').with_device('/dev/sdc') }

    it { should contain_file('/etc/udev/rules.d/90-ceph-osd-47.rules').with_content('KERNEL=="/dev/sdb1", SUBSYSTEM=="block", OWNER="ceph"') }
  end
end
