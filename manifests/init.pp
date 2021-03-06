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
# [*repo_url*]
#   Apt mirror repo url (Example: http://nice.mirror.com/ceph/jewel)
#
# [*key_url*]
#   Apt key url (http://download.ceph.com/keys/release.asc)
#
# [*os_release*]
#   Override os release name for package source (For example if you use Debian Jessie, but
#   want to use the wheezy sources from the ceph repository.

class ceph (
  $mon_hosts,
  $cluster_net                               = $::ceph::params::cluster_net,
  $osd_pool_default_crush_replicated_ruleset = $::ceph::params::osd_pool_default_crush_replicated_ruleset,
  $osd_pool_default_size                     = $::ceph::params::osd_pool_default_size,
  $osd_recovery_op_priority                  = $::ceph::params::osd_recovery_op_priority,
  $os_release                                = $::ceph::params::os_release,
  $public_net                                = $::ceph::params::public_net,
  $release                                   = $::ceph::params::release,
  $repo_url                                  = $::ceph::params::repo_url,
  $key_url                                   = $::ceph::params::key_url,
  $osd_max_backfills                         = $::ceph::params::osd_max_backfills,
  $osd_recovery_max_active                   = $::ceph::params::osd_recovery_max_active,
  $log_to_syslog                             = $::ceph::params::log_to_syslog,
  $log_file                                  = $::ceph::params::log_file,
  $config_dir_mode                           = $::ceph::params::config_dir_mode,
  $config_dir_group                          = $::ceph::params::config_dir_group,
  $osd_heartbeat_grace                       = $::ceph::params::osd_heartbeat_grace,
  $mon_osd_min_down_reporters                = $::ceph::params::mon_osd_min_down_reporters,
  $mon_osd_down_out_interval                 = $::ceph::params::mon_osd_down_out_interval,
  ) inherits ceph::params {

  include ::ceph::install
  include ::ceph::config
  Class['::ceph::install'] -> Class['::ceph::config']
}
