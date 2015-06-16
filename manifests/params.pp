# == Class: ceph::params
#
# This module configures stuff common to all ceph hosts
#
# === Parameters
#
# [*mon_hosts*]
#   This contains a list of all monitor hosts, it is used by all ceph servers
#   and clients to find the mons.
#

class ceph::params {
  $cluster_net = $::ipaddress
  $public_net  = $::ipaddress
}
