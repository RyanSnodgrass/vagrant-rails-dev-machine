# RVM module must exist and have had the libcurl dependency file modified to work
# on Amazon Linux (by changing the default to libcurl-devel in /manifests/dependencies/centos.pp)
include rvm
rvm_system_ruby {
  'ruby-1.9.3':
    ensure => 'present',
    default_use => true;
}
rvm_gem {
  'bundler':
    name => 'bundler',
    ruby_version => 'ruby-1.9.3',
    ensure => latest,
    require => Rvm_system_ruby['ruby-1.9.3'];
}
rvm_gem {
  'rails':
    name => 'rails',
    ruby_version => 'ruby-1.9.3',
    ensure => '3.2.14',
    require => Rvm_system_ruby['ruby-1.9.3'];
}
