# == Class: ceph::params
#
#
class ceph::params {
  $cluster_net                               = undef
  $public_net                                = undef
  $os_release                                = $::lsbdistcodename
  $repo_url                                  = undef
  $key_url                                   = undef
  $release                                   = undef
  $log_file                                  = undef
  $log_to_syslog                             = undef
  $osd_pool_default_crush_replicated_ruleset = undef
  $osd_pool_default_size                     = undef
  $config_dir_mode                           = '0750'
  $osd_recovery_op_priority                  = undef
  $osd_max_backfills                         = undef
  $osd_recovery_max_active                   = undef
  $config_dir_group                          = 'ceph'
  $osd_heartbeat_grace                       = undef
  $mon_osd_min_down_reporters                = undef
}
