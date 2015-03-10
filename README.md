Vagrantfile that installs...

- opneresty (nginx variant with lua hooks)
- oracle instant client
- rvm with ruby 2.0 / rails 3.2.16 defaults
- "deploy" user with /apps directory for app deployments
- no host firewall

## Steps

1. `git clone https://github.com/ndoit/vagrant-rails-dev-machine`
2. `cd vagrant-rails-dev-machine`
3. `git checkout bi-portal`

4. `vagrant up`

5. `vagrant ssh`
6. `cd /vagrant`

7. `. keys.sh (follow prompt)` You'll need the .env.local keys for this prompt
8. `. restart_services.sh`

9. `. bulk_load.sh (follow prompt)`
