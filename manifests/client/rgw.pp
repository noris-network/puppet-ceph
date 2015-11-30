# == Class: admin_ceph::client::rgw
#
# This module configures a rados-gateway client for ceph
#
# [*rgw_dns_name*]
#   base dns name of your rgw (example: rgw.example.com)


class ceph::client::rgw ($rgw_dns_name) {
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
    require => [ Package['radosgw'], Class['::ceph::config'] ]
  }

  class {'::apache':
    default_mods     => false,
    default_vhost    => false,
    server_tokens    => 'Prod',
    server_signature => 'Off',
    trace_enable     => 'Off',
    mpm_module       => 'prefork',
  }

  include apache::mod::auth_basic

  file{'/var/www/fcgi':
    ensure => directory,
  }
}
