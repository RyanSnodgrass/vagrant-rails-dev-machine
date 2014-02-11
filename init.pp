#VARIABLES
$user = "deploy"
$apps_home_dir = "/apps"

file {"apps dir":
	ensure =>	directory,
  	path => 	"${apps_home_dir}",
	mode =>		"0775",
	owner =>	$user,
        group =>	"rvm"
  }

group { "deploy":
    ensure => "present",
}
->
user_homedir { "deploy":
  group => "deploy",
  fullname => "Otto the Deployer",
  ingroups => ["deploy", "rvm"]
}
user_homedir { "vagrant":
  group => "deploy",
  fullname => "Vagrant Default",
  ingroups => ["deploy", "rvm"]
}



define user_homedir ($group, $fullname, $ingroups) {
  user { "$name":
    ensure => present,
    comment => "$fullname",
    gid => "$group",
    groups => $ingroups,
    membership => minimum,
    shell => "/bin/bash",
    home => "/home/$name",
    require => Group[$group],
  }

  exec { "$name homedir":
    command => "/bin/cp -R /etc/skel /home/$name; /bin/chown -R $name:$group /home/$name",
    creates => "/home/$name",
    require => User[$name],
  }
}

# GLOBAL PATH SETTING
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

ssh::resource::known_hosts { 'add git to known_hosts':
  hosts => 'github.com',
  user => $user,
}

#class { 'known_hosts':
#    	user =>	$user,
#	site => 'github.com'
#}
#
## REUSABLE TO ADD KNOWN_HOSTS
#class known_hosts (
#    $user = "",
#    $site = ""  
#){
#
#  exec {"add site to known_hosts for user":
#       	command => 		"ssh-keyscan -H ${site} >> /home/${user}/.ssh/known_hosts"
#  }
#
#}

class { 'openresty':
    openresty_home => '/usr/local/openresty'
}
#include openresty
include oracle_instant_client



# I am getting the error in this issue: https://github.com/wayneeseguin/rvm/issues/2496
# A pull request was merged to fix it.  This was 2 days ago ( 12/31/2013? ).  I did not get the error BEFORE this..
# so either the pull request causes the error for me, or this puppet module is not getting the latest RVM.  So I'm trying to specify
# the version number of RVM to see what happens.
# reference to the issue, where I put in my report: https://github.com/wayneeseguin/rvm/issues/2496#issuecomment-31479728
class { 'rvm': version => '1.25.10' }

class { 'install_things_with_rvm':
    ruby_ver => 'ruby-2.0.0'
}
package{ 'subversion':
	ensure => 'installed',
	provider => 'yum'
}
package{ 'nodejs':
	ensure => 'installed',
	provider => 'yum'
}

# RVM module must exist and have had the libcurl dependency file modified to work
# on Amazon Linux (by changing the default to libcurl-devel in /manifests/dependencies/centos.pp)
class install_things_with_rvm (
    $ruby_ver = 'ruby-1.9.3',
    $rails_ver = '3.2.16'
){
    require rvm

    rvm_system_ruby {
      $ruby_ver:
        ensure => 'present',
        default_use => true;
    }
    rvm_gem {
      'bundler':
        name => 'bundler',
        ruby_version => $ruby_ver,
        ensure => latest,
        require => Rvm_system_ruby[$ruby_ver];
    }
    rvm_gem {
      'rails':
        name => 'rails',
        ruby_version => $ruby_ver,
        ensure => $rails_ver,
        require => Rvm_system_ruby[$ruby_ver];
    }
    package{
      'sqlite-devel':
    	ensure => 'installed',
    	provider => 'yum'
    }
}

