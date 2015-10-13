# == Class: admin_ceph::client::rgw
#
# This module configures a rados-gateway client for ceph
#
class ceph::client::rgw ($rgw_dns_name){
  concat::fragment { '/etc/ceph/ceph.conf-rgw':
    target  => '/etc/ceph/ceph.conf',
    content => template("${module_name}/ceph.conf-rgw.erb"),
    order   => 2,
  }

  package {'radosgw':
    ensure => installed,
  }

  service {'radosgw':
    ensure => running,
  }

  file { '/var/www/fcgi':
    ensure => directory,
  }

  file { ['/var/www/fcgi/rgw.fcgi','/var/www/fcgi/rgw-ssl.fcgi','/var/www/fcgi/rgw-ssl-stern.fcgi']:
    ensure  => file,
    mode    => '0555',
    content => '#!/bin/bash
exec /usr/bin/radosgw -c /etc/ceph/ceph.conf -n client.radosgw.rgw
'
  }
}
