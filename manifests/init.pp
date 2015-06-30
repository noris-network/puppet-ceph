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
# [*release*]
#   Ceph release (Example: firefly)
#
# [*os_release*]
#   Override os release name for package source (For example if you use Debian Jessie, but
#   want to use the wheezy sources from the ceph repository.
#
# [*cluster_net*]
#   If you want to have a separate cluster and public network, you can specify your cluster networks here.
#
# [*public_net*]
#   If you want to have a separate cluster and public network, you can specify your public networks here.
#

class ceph (
  $mon_hosts,
  $release,
  $os_release  = $::ceph::params::os_release,
  $cluster_net = $::ceph::params::cluster_net,
  $public_net  = $::ceph::params::public_net,
  ) inherits ceph::params {
  include ::ceph::install
  include ::ceph::config
}
