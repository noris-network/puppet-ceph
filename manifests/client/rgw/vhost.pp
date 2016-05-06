# == Define: admin_ceph::client::rgw::vhost
#
# This define configures a rados-gateway vhost for ceph
#
# [*ip*]
#   ip for the vhost
#
# [*crt*]
#   ssl certificate
#
# [*key*]
#   ssl key for connections to <rgw_dns_name> (example: rgw.example.com)
#
# [*crt_chain*]
#   if your ssl certificate needs an intermediate certificate, then you can specifiy it here.
#

define ceph::client::rgw::vhost (
  $crt       = undef,
  $ip        = undef,
  $key       = undef,
  $ssl       = false,
  $crt_chain = undef,
  ){

  apache::vhost {$title:
    docroot              => '/var/www',
    fastcgi_socket       => '/var/run/ceph/radosgw.sock',
    fastcgi_dir          => '/var/www/fcgi',
    fastcgi_server       => "/var/www/fcgi/${title}.fcgi",
    fastcgi_idle_timeout => 120,
    rewrites             => [ {
      'rewrite_rule' => [ "^/([a-zA-Z0-9-_.]*)([/]?.*) /fcgi/${title}.fcgi?page=\$1&params=\$2&%{QUERY_STRING} [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]" ]
    } ],
  }

  if $ssl {
    ensure_resource('apache::listen','443')

    file{"/etc/ssl/certs/${title}.crt":
      ensure  => file,
      content => $crt,
    }
    file{"/etc/ssl/private/${title}.key":
      ensure  => file,
      content => $key,
    }
    Apache::Vhost[$title] {
      port       => 443,
      ssl        => true,
      add_listen => false,
      ip_based   => true,
      ip         => $ip,
      ssl_cert   => "/etc/ssl/certs/${title}.crt",
      ssl_key    => "/etc/ssl/private/${title}.key",
    }
  }

  else {
    ensure_resource('apache::listen','80')
    Apache::Vhost[$title] {
      port           => 80,
      servername     => $::fqdn,
    }
  }

  if $crt_chain {
    Apache::Vhost[$title] {
      ssl_chain  => "/etc/ssl/certs/${title}_chain.crt",
    }
    file {"/etc/ssl/certs/${title}_chain.crt":
      ensure  => file,
      content => $crt_chain,
    }
  }
}
