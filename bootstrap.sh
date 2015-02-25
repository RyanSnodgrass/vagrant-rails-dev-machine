#!/bin/bash/

echo -e "$COL_RED Now Triggering bootstrap.sh $COL_RESET"
rvm use 2.0.0 --create

makeAppsDirectory(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW=============Instantiating Apps Directory===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  mkdir apps
}

cdToApps(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW=============Entering Apps Directory================$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  cd ./apps/;
}

cloneMuninn(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW====================Cloning Muninn==================$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_MAGENTA         _  $COL_RESET"
  echo -e "$COL_MAGENTA        /.) $COL_RESET"
  echo -e "$COL_MAGENTA       /)\| $COL_RESET"
  echo -e "$COL_MAGENTA      /|)/  $COL_RESET"
  echo -e "$COL_MAGENTA     /'^^'  $COL_RESET"


  git clone https://github.com/ndoit/muninn;
}

cloneHuginn(){
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW====================Cloning Huginn==================$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_MAGENTA           _     $COL_RESET"
  echo -e "$COL_MAGENTA          (.\    $COL_RESET"
  echo -e "$COL_MAGENTA          |/(\   $COL_RESET"
  echo -e "$COL_MAGENTA           \)|\  $COL_RESET"
  echo -e "$COL_MAGENTA           '^^'\ $COL_RESET"

  git clone https://github.com/ndoit/huginn
}

bundleInstallMuninn(){
  cd ./muninn/;
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW===========Starting Bundle Install Muninn===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  bundle install;
}

cdBackToAppsDirectory(){
  cd ./../;
}

bundleInstallHuginn(){
  cd ./huginn/;
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  echo -e "$COL_YELLOW===========Starting Bundle Install Huginn===========$COL_RESET"
  echo -e "$COL_YELLOW====================================================$COL_RESET"
  bundle install;
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
cdToApps
cloneMuninn
cloneHuginn
bundleInstallMuninn
cdBackToAppsDirectory
bundleInstallHuginn
cdBackToAppsDirectory
completionMessage



ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"
