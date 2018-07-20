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
  $rgw_dynamic_resharding      = undef,
  $rgw_frontends = "civetweb port=${rgw_civetweb_port}",
  $rgw_max_attr_size = undef,
  $rgw_max_attrs_num_in_req = undef,
  $rgw_max_attr_name_len = undef,
  $rgw_keystone_url = undef,
  $rgw_keystone_api_version = 3,
  $rgw_keystone_admin_user = undef,
  $rgw_keystone_admin_password = undef,
  $rgw_keystone_admin_domain = 'Default',
  $rgw_keystone_admin_project = 'services',
  $rgw_keystone_accepted_roles = 'admin,_member_',
  $rgw_keystone_accepted_admin_roles = 'admin',
  $rgw_keystone_token_cache_size = undef,
  $rgw_keystone_revocation_interval = undef,
  $rgw_keystone_implicit_tenants = true,
  $rgw_s3_auth_use_keystone = true,
  $rgw_swift_enforce_content_length = true,
  $rgw_swift_account_in_url = true,
  $rgw_swift_versioning_enabled = true,
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
