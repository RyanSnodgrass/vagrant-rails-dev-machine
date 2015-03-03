# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 443, host: 4443
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 3001, host: 3001
  config.vm.network :forwarded_port, guest: 3002, host: 3002
  config.vm.network :forwarded_port, guest: 7474, host: 7474
  config.vm.network :forwarded_port, guest: 9200, host: 9200

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
end

  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
#


$provisions = <<SCRIPT

echo Preparing to provision...
echo Installing git
yum install -y git
#yum update -y

echo Preparing puppet scripts...
if [ ! -d "/usr/share/puppet/modules/rvm" ]; then
  git clone https://github.com/ndoit/puppet-rvm.git  /etc/puppet/modules/rvm
   git clone https://github.com/ndoit/puppet-oracle-instant /etc/puppet/modules/oracle_instant_client
   git clone https://github.com/ndoit/puppet-ssh.git /etc/puppet/modules/ssh
   git clone https://github.com/ndoit/puppetlabs-firewall /etc/puppet/modules/firewall
   git clone https://github.com/ndoit/puppet-sudo /etc/puppet/modules/sudo
   git clone https://github.com/ndoit/puppetlabs-stdlib /etc/puppet/modules/stdlib
   git clone https://github.com/ndoit/puppet-elasticsearch /etc/puppet/modules/elasticsearch
   git clone https://github.com/ndoit/puppet-neo4j /etc/puppet/modules/neo4j
   git clone https://github.com/ndoit/puppet-rails-template.git /tmp/manifests/
fi

echo Getting epel and remi files...
# ran into trouble installing libyaml-devl on centos.  adding the EPEL repo as described here fixed it
# http://maverickgeekstuffs.blogspot.com/2013/03/installing-libyaml-devel-in-centos.html
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

echo Running SED...
# fix from https://community.hpcloud.com/article/centos-63-instance-giving-cannot-retrieve-metalink-repository-epel-error
sudo sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo

echo Applying init and bi-portal-extras puppet files...
sudo puppet apply --verbose --debug /tmp/manifests/init.pp
sudo puppet apply --verbose --debug /tmp/manifests/bi-portal-extras.pp

echo Implimenting usermod...
usermod -a -G rvm vagrant

SCRIPT


$restart_services = <<SCRIPT
echo Preparing nginx...
cp /vagrant/apps/huginn/config/huginn_nginx_conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/huginn_nginx_conf /etc/nginx/sites-enabled/

echo Applying databases puppets...
sudo puppet apply --verbose --debug /tmp/manifests/bi-portal-extras.pp

echo Killing extraneous processes...
/etc/init.d/iptables stop
/usr/local/share/neo4j/bin/neo4j stop
/usr/local/share/elasticsearch/bin/service/elasticsearch stop
kill -9 $(cat /vagrant/apps/huginn/tmp/pid/unicorn.pid )
kill -9 $(cat /vagrant/apps/muninn/tmp/pid/unicorn.pid )
/usr/sbin/nginx -s stop

echo Starting neo4j and elastic search...
/usr/local/share/neo4j/bin/neo4j start
/usr/local/share/elasticsearch/bin/service/elasticsearch start
/usr/sbin/nginx

SCRIPT


  config.vm.provision "shell", inline: $provisions
  config.vm.provision "shell" do |s|
    s.path = "bootstrap.sh"
  end
  config.vm.provision "shell", inline: $restart_services
  #

  # config.vm.provision "shell", path: "restart_services.sh"
  # from rvm module writer's sample vagrant file
  #config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/epel || puppet module install stahnma/epel -v 0.0.3"


  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  #config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "./manifests"
  #   puppet.manifest_file  = "init.pp"
  #end


  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
