# == Class: ceph::client::rgw::haproxy
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

class ceph::client::rgw::haproxy (
  $pems              = [],
  $rgw_civetweb_port = 7480,
  $logserver         = $::ipaddress,
  ){

  class{'haproxy':
    defaults_options => {
      'option'  => 'httplog clf',
      'timeout' => [
        'connect 5000',
        'client 50000',
        'server 50000',
      ]
    },
    global_options   => {
      'log'   => "${logserver} local0",
      'group' => 'haproxy',
      'user'  => 'haproxy',
    },
  }

  haproxy::frontend { 'http':
    bind    => {
      '0.0.0.0:80' => [],
    },
    mode    => 'http',
    options => {
      'default_backend' => 'civetweb',
    }
  }

  if ($pems) {
    $prefixed = prefix($pems, 'crt ')
    $ssl = flatten(['ssl',$prefixed ])
    haproxy::frontend { 'https':
      bind    => {
        '0.0.0.0:443' => $ssl,
      },
      mode    => 'http',
      options => {
        'default_backend' => 'civetweb',
      }
    }
  }

  haproxy::balancermember { 'civetweb':
    listening_service => 'civetweb',
    ports             => '7480',
    server_names      => ['localhost'],
    ipaddresses       => '127.0.0.1',
    options           => 'check',
  }

  haproxy::backend { 'civetweb':
    mode    => http,
    options => {},
  }
}
