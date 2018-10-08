#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - /etc/issue* has correct branding"
if [ "$el_ver" = "7" ] ; then
  t_Log "CentOS $el_ver -> SKIP"
  exit 0
else
  (grep "CentOS" /etc/issue >/dev/null 2>&1) && \
  (grep "CentOS" /etc/issue.net >/dev/null 2>&1) 
  t_CheckExitStatus $?
fi
