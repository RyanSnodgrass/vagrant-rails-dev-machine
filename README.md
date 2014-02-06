vagrant-rails-cas
=================

Vagrantfile to set up the ND Rails stack, and install a rails app with a self-signed cert that can authenticate to CAS (test).

HTTPS will be forwarded from 443 on the VM to 4443 on the host.


Deploy the CAS app:
--------------------
Unforunately, in this version, you still have to manually start the app.  Fortunately, it's pretty automated.

SSH into vagrant (`vagrant ssh` on mac) then...

    cd ~/cas
    bundle install
    bundle exec cap vagrant deploy:first_time

This will deploy to localhost (the vagrant VM) as if it's a remote machine.  It will install to the /apps directory and start it running.  On your laptop:

    https://localhost:4443
