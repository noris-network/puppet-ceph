# == Class: ceph::params
#
#
class ceph::params {
  $cluster_net   = undef
  $public_net    = undef
  $os_release    = $::lsbdistcodename
  $release       = undef
  $log_file      = undef
  $log_to_syslog = undef
  $ceph_dir_mode = '0750'
}
