#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

# nc (netcat) is required for the test

<<<<<<< HEAD
if [ "$el_ver" = "7" ] ;then
=======
if [ "$centos_ver" -ge 8 ] ;then
  t_Log "No whois package for CentOS $centos_ver -> SKIP"
  t_CheckExitStatus 0
  exit 0
elif [ "$centos_ver" = "7" ] ;then
>>>>>>> 91ec2259bdd19c2a1a3261e92d1c3df08fd6b6ce
  whois_pkg="whois"
else
  whois_pkg="jwhois"
fi

t_InstallPackage $whois_pkg nc

