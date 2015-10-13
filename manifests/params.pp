# == Class: ceph::params
#
#
class ceph::params {
  $cluster_net = undef
  $public_net  = undef
  $os_release  = $::lsbdistcodename
  $release     = undef
}
