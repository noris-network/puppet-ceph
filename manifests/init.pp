# == Class: ceph
#
# This module configures stuff common to all ceph hosts
#
# === Parameters
#
# [*mon_hosts*]
#   This contains a list of all monitor hosts, it is used by all ceph servers
#   and clients to find the mons.
#

class ceph (
  $mon_hosts,
  $release,
  $cluster_net = $::ceph::params::cluster_net,
  $public_net  = $::ceph::params::public_net,
  ) inherits ceph::params {
  include ::ceph::install
  include ::ceph::config
}
