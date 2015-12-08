# == Class: admin_ceph::mon
#
# This module configures a mon server for ceph
#
# === Parameters
#
# [*id*]
#   The id of this monitor.
#
# [*log_to_syslog*]
#   Enable logging to syslog
#
# [*mon_log_file*]
#   Location of logfile
#
class ceph::server::mon ($id, $log_to_syslog=undef, $mon_log_file=undef){

  concat::fragment { '/etc/ceph/ceph.conf-mon':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-mon.erb"),
    order   => 2,
  }
}
