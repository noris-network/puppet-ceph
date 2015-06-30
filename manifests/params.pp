# == Class: ceph::params
#
#  This class contains the default parameters
#
class ceph::params {
  $cluster_net = $::ipaddress
  $public_net  = $::ipaddress
  $os_release  = $::lsbdistcodename
}
