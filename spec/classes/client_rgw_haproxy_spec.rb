require 'spec_helper'
describe 'ceph::client::rgw::haproxy' do

  let(:facts) { {'hostname' => 'rgw', :concat_basedir => '/dne', :operatingsystemrelease => '8.1', :osfamily => 'Debian', :operatingsystem => 'Debian', :ipaddress => '1.2.3.4', :fqdn => 'rgw.foo.bar' } }
  let(:pre_condition) { 'class {"::ceph::client::rgw": rgw_dns_name => "foo.bar" }' }

  let(:params) { {
    :rgw_civetweb_port => 7480,
    :logserver         => 'logserver'
  }}

  it { should contain_class('haproxy').with(
    :defaults_options => {
      "option"  => 'httplog clf',
      "timeout" => [
        "connect 5000",
        "client 50000",
        "server 50000",
      ]
    },
    :global_options => {
      'log' => 'logserver local0 debug',
      'log-send-hostname' => 'rgw.foo.bar',
      'group' => 'haproxy',
      'user' => 'haproxy'
    }
  )}
  it { should contain_haproxy__frontend('http').with(
    :bind => { '0.0.0.0:80' => [] },
    :mode => 'http',
    :options => {
      "default_backend" => 'civetweb'
    }
  )}

  it { should contain_haproxy__backend('civetweb').with(
    :mode => 'http',
    :options => {},
  )}

  it { should contain_haproxy__balancermember('civetweb').with(
    :listening_service => 'civetweb',
    :ports => 7480,
    :server_names => [ 'localhost' ],
    :ipaddresses => '127.0.0.1'
  )}

  context 'with ssl enabled' do
    let(:params) { {
      :rgw_civetweb_port => 7480,
      :pems      => ['foo','bar'],
    }}

    it { should contain_haproxy__frontend('https').with( {
      :bind => { '0.0.0.0:443' => [ 'ssl', 'crt foo', 'crt bar' ] },
      :mode => 'http',
      :options => {
         "default_backend" => 'civetweb'
      }
    }) }
  end
end
