#!/bin/bash/

makeAppsDirectory(){
  echo "===================================================="
  echo "=============Instantiating Apps Directory==========="
  echo "===================================================="
  mkdir apps
}

cdToApps(){
  echo "===================================================="
  echo "=============Entering Apps Directory================"
  echo "===================================================="
  cd ./apps/;
}

cloneMuninn(){
  echo "===================================================="
  echo "====================Cloning Muninn=================="
  echo "===================================================="
  echo "         _  "
  echo "        /.) "
  echo "       /)\| "
  echo "      /|)/  "
  echo "     /'^^'  "


  git clone https://github.com/ndoit/muninn;
}

cloneHuginn(){
  echo "===================================================="
  echo "====================Cloning Huginn=================="
  echo "===================================================="
  echo "           _     "
  echo "          (.\    "
  echo "          |/(\   "
  echo "           \)|\  "
  echo "           '^^'\ "

  git clone https://github.com/ndoit/huginn
}

bundleInstallMuninn(){
  cd ./muninn/;
  echo "===================================================="
  echo "===========Starting Bundle Install Muninn==========="
  echo "===================================================="
  bundle install;
}

cdBackToAppsDirectory(){
  cd ./../;
}

bundleInstallHuginn(){
  cd ./huginn/;
  echo "===================================================="
  echo "===========Starting Bundle Install Huginn==========="
  echo "===================================================="
  bundle install;
}

completionMessage(){
  echo "===================================================="
  echo "===========Huginn & Muninn have completed==========="
  echo "================thought & mind are one=============="
  echo "===================================================="
  echo "                       _     _                      "
  echo "                      /.)   (.\                     "
  echo "                     /)\|   |/)\                    "
  echo "                    /|)/     \(|\                   "
  echo "                   /'^^'     '^^'\                  "
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
