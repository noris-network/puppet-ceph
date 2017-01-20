# == Class: ceph::config
#
# This module configures stuff common to all ceph hosts
#

class ceph::config {

  $cluster_net                               = $::ceph::cluster_net
  $mon_hosts                                 = $::ceph::mon_hosts
  $osd_recovery_max_active                   = $::ceph::osd_recovery_max_active
  $public_net                                = $::ceph::public_net
  $osd_max_backfills                         = $::ceph::osd_max_backfills
  $osd_recovery_op_priority                  = $::ceph::osd_recovery_op_priority
  $osd_pool_default_size                     = $::ceph::osd_pool_default_size
  $osd_pool_default_crush_replicated_ruleset = $::ceph::osd_pool_default_crush_replicated_ruleset
  $log_to_syslog                             = $::ceph::log_to_syslog
  $log_file                                  = $::ceph::log_file
  $config_dir_mode                           = $::ceph::config_dir_mode
  $config_dir_group                          = $::ceph::config_dir_group
  $osd_heartbeat_grace                       = $::ceph::osd_heartbeat_grace

  file { [ '/etc/ceph' ]:
    ensure => directory,
    owner  => 'root',
    group  => $config_dir_group,
    mode   => $config_dir_mode,
  }

  ceph::config::main_config{'/etc/ceph/ceph.conf':
    cluster_net                               => $cluster_net,
    mon_hosts                                 => $mon_hosts,
    osd_recovery_max_active                   => $osd_recovery_max_active,
    public_net                                => $public_net,
    osd_max_backfills                         => $osd_max_backfills,
    osd_recovery_op_priority                  => $osd_recovery_op_priority,
    osd_pool_default_size                     => $osd_pool_default_size,
    osd_pool_default_crush_replicated_ruleset => $osd_pool_default_crush_replicated_ruleset,
    log_to_syslog                             => $log_to_syslog,
    log_file                                  => $log_file,
    config_dir_mode                           => $config_dir_mode,
    config_dir_group                          => $config_dir_group,
    osd_heartbeat_grace                       => $osd_heartbeat_grace,
  }

  concat { '/etc/ceph/keyring': }
  concat::fragment { '/etc/ceph/keyring-head':
    target  => '/etc/ceph/keyring',
    content => "# This file is generated by puppet\n",
    order   => '0001',
  }

  concat { '/etc/ceph/rbdmap': }
  concat::fragment { '/etc/ceph/rbdmap-head':
    target  => '/etc/ceph/rbdmap',
    content => "# This file is generated by puppet\n",
    order   => '0001',
  }
}
