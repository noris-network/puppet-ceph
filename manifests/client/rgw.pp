# == Class: admin_ceph::client::rgw
#
# This module configures a rados-gateway client for ceph
#
# [*rgw_dns_name*]
#   base dns name of your rgw (example: rgw.example.com)
#
# [*rgw_bucket_index_max_shards*]
#   Use this number of shards for newly created bucket indexes.
#

class ceph::client::rgw (
  $rgw_dns_name,
  $rgw_bucket_index_max_shards = undef,
  $rgw_civetweb_port           = 7480,
) {
  concat::fragment { '/etc/ceph/ceph.conf-rgw':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-rgw.erb"),
    order   => 2,
  }

  package {'radosgw':
    ensure => installed,
  }
  service {'radosgw':
    ensure  => running,
    require => [ Package['radosgw'], Class['::ceph::config'] ],
  }

  file {'/var/run/ceph/ceph-client.radosgw.rgw.asok':
    owner => 'ceph',
  }

}
