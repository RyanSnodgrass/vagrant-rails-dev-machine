#!/usr/bin/env bash

echo -e "$COL_RED Now Triggering bootstrap.sh $COL_RESET"
# source /usr/local/rvm/scripts/rvm
# rvm use 2.0.0 --create
gem install bundler

makeAppsDirectory(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW=============Instantiating Apps Directory===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  mkdir /vagrant/apps
}


cloneMuninn(){
  echo -e "$COL_MAGENTA=========================================================================$COL_RESET"
  echo -e "$COL_MAGENTA====================================Cloning Muninn=======================$COL_RESET"
  echo -e "$COL_MAGENTA=========================================================================$COL_RESET"
  echo '

  __________-------____                 ____-------__________
  \------____-------___--__---------__--___-------____------/
   \//////// / / / / / \   .-------.   / \ \ \ \ \ \\\\\\\\/
     \////-/-/------/_/_|  //     \\  |_\_\------\-\-\\\\/
       --//// / /  /  //|  | o___o |  | ||\\  \  \ \ \\\\--
            ---__/  // /|  \ _____ /  |\ \\  \__---
                 -//  / /\_ \     / _/\ \  \\-
                   \_/_/ /\--\   /--/\ \_\_/
                       ----\  \ /  /----
                            |  -  |
                          / /_ | _\ \
                         / // / \ \\ \
                        ////_|| ||_\\\\
  '

  git clone https://github.com/ndoit/muninn /vagrant/apps/muninn
}

cloneHuginn(){
  echo -e "$COL_MAGENTA=======================================================================$COL_RESET"
  echo -e "$COL_MAGENTA=======================================Cloning Huginn==================$COL_RESET"
  echo -e "$COL_MAGENTA=======================================================================$COL_RESET"
  echo '

  __________-------____                 ____-------__________
  \------____-------___--__---------__--___-------____------/
   \//////// / / / / / \   .-------.   / \ \ \ \ \ \\\\\\\\/
     \////-/-/------/_/_|  //     \\  |_\_\------\-\-\\\\/
       --//// / /  /  //|  | o___o |  | ||\\  \  \ \ \\\\--
            ---__/  // /|  \ _____ /  |\ \\  \__---
                 -//  / /\_ \     / _/\ \  \\-
                   \_/_/ /\--\   /--/\ \_\_/
                       ----\  \ /  /----
                            |  -  |
                          / /_ | _\ \
                         / // / \ \\ \
                        ////_|| ||_\\\\
  '

  git clone https://github.com/ndoit/huginn /vagrant/apps/huginn
}

bundleInstallMuninn(){
  cd /vagrant/apps/muninn/
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW===========Starting Bundle Install Muninn===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  bundle install
}


bundleInstallHuginn(){
  cd /vagrant/apps/huginn/
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW===========Starting Bundle Install Huginn===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  bundle install
}




completionMessage(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW===========Huginn & Muninn have completed===========$COL_RESET"
  echo -e "$COL_YELLOW================thought & mind are one==============$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_MAGENTA                       _     _                      $COL_RESET"
  echo -e "$COL_MAGENTA                      /.)   (.\                     $COL_RESET"
  echo -e "$COL_MAGENTA                     /)\|   |/)\                    $COL_RESET"
  echo -e "$COL_MAGENTA                    /|)/     \(|\                   $COL_RESET"
  echo -e "$COL_MAGENTA                   /'^^'     '^^'\                  $COL_RESET"
}

makeAppsDirectory
cloneMuninn
cloneHuginn
bundleInstallMuninn
bundleInstallHuginn
completionMessage



ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
