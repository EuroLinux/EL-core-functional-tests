#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - initscripts CentOS branding "

if [ "$el_ver" -gt "5" ] ; then
  t_Log "Test not required for CentOS $el_ver -> SKIP"
  exit 0
else
  grep "CentOS" /etc/rc.sysinit > /dev/null 2>&1
fi

t_CheckExitStatus $?
