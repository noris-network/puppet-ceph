# == Define: ceph::config
#
# This module configures stuff common to all ceph hosts
#

define ceph::config::main_config (
  $cluster_net                               = undef,
  $mon_hosts                                 = undef,
  $osd_recovery_max_active                   = undef,
  $public_net                                = undef,
  $osd_max_backfills                         = undef,
  $osd_recovery_op_priority                  = undef,
  $osd_pool_default_size                     = undef,
  $osd_pool_default_crush_replicated_ruleset = undef,
  $log_to_syslog                             = undef,
  $log_file                                  = undef,
  $config_dir_mode                           = '0750',
  $config_dir_group                          = 'ceph',
  $osd_heartbeat_grace                       = undef,
  $additional_options                        = undef,
  $mon_osd_min_down_reporters                = undef,
  $mon_osd_down_out_interval                 = undef,
) {

  concat { $title: }
  concat::fragment { "${title}-ceph-main":
    target  => $title,
    content => template("${module_name}/ceph.conf-main.erb"),
    order   => '0001',
  }
}
