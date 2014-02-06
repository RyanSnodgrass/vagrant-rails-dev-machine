vagrant-rails-cas
=================

Vagrantfile to set up the ND Rails stack, and install a rails app with a self-signed cert that can authenticate to CAS (test).

HTTPS will be forwarded from 443 on the VM to 4443 on the host.


Deploy the CAS app:
--------------------
Unforunately, in the current form, "root" cannot run "bundle install" because it can't install bundler.  So you will have to manually start the app.  Fortunately, that's pretty automated.

SSH into vagrant (`vagrant ssh` on mac) then...

    cd ~/cas
    bundle install
    bundle exec cap vagrant deploy:first_time

Now it's running.  On your laptop:

    https://localhost:4443
