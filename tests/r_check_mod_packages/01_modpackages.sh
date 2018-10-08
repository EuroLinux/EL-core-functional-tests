#!/bin/bash
# Author: Johnny Hughes <johnny@centos.org>
# Note: This test is only for Pre Updates testing prior to releasing on CentOS

uname_arch=$(uname -m)

if [ $SKIP_QA_HARNESS -eq 1 ] && [ "$PRE_UPDATES" != "1" ] ; then
    t_Log "Skip $0 in non QA harness environment"
    ret_val=0
elif [ "$uname_arch" == "armv7l" ] ; then
    t_Log "*** Not testing $0 on Arch: $uname_arch ***"
    ret_val=0
else
  ret_val=0
  if [ "$el_ver" = "7" ] ; then
   
   t_Log "Running $0 - Checking current repositories for .el7.centos on modified files"
   uname_arch=$(uname -m)
   yum clean all
    for pkg in $(cat tests/r_check_mod_packages/c72-mod-packages.lst.$uname_arch) 
      do 
         has_centos=$(yum list $pkg | grep '.el7.centos')
         if [ "$has_centos" == "" ]; then 
           echo $pkg missing .el7.centos
           ret_val=1
         fi
      done
  else
    t_Log "Skipping $0 - This test only for CentOS-7, skipping Modified Packages test ..."
    ret_val=0
  fi


  t_CheckExitStatus $ret_val
fi
