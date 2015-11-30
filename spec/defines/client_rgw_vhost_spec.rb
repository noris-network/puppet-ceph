require 'spec_helper'
describe 'ceph::client::rgw::vhost',  :type => :define do

  let(:facts) { {'hostname' => 'rgw', :concat_basedir => '/dne', :operatingsystemrelease => '8.1', :osfamily => 'Debian'} }
  let(:title) { "vhost" }
  let(:pre_condition) { 'class {"::ceph::client::rgw": rgw_dns_name => "foo.bar" }' }

  context 'with ssl disabled' do
    let(:params) { {
      :ssl => false,
      :ip  => '1.2.3.4',
    }}
    it { should contain_apache__namevirtualhost('*:80') }
    it { should contain_apache__vhost('vhost').with( {
      :fastcgi_server => "/var/www/fcgi/vhost.fcgi",
    }) }
    it { should contain_apache__listen('80') }
    it { should contain_apache__namevirtualhost('*:80') }
  end
  context 'with ssl enabled' do
    let(:params) { {
      :ssl       => true,
      :ip        => '1.2.3.4',
      :crt_chain => 'foo',
      :crt       => 'foo',
      :key       => 'foo',
    }}
    it { should contain_apache__vhost('vhost').with( {
      :fastcgi_server => "/var/www/fcgi/vhost.fcgi",
      :ip => '1.2.3.4',
      :ssl_cert => '/etc/ssl/certs/vhost.crt',
      :ssl_key => '/etc/ssl/private/vhost.key'
    }) }
    it { should contain_file('/etc/ssl/certs/vhost_chain.crt').with_content(/foo/) }
    it { should contain_file('/etc/ssl/certs/vhost.crt').with_content(/foo/) }
    it { should contain_file('/etc/ssl/private/vhost.key').with_content(/foo/) }
    it { should contain_apache__listen('443') }
  end

end
