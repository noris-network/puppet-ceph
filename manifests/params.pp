# == Class: ceph::params
#
#
class ceph::params {
  $cluster_net = $::ipaddress
  $public_net  = $::ipaddress
  $os_release  = $::lsbdistcodename
}
