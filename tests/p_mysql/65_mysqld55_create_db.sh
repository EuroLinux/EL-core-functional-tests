#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - MySQL55 create database test"

if [ $el_ver -gt 5 ]
then
  t_Log 'mysql55 is only supported on C5, skipping'
  t_CheckExitStatus 0       
  exit 0
fi

mysql -u root -e 'create database mysql_test' >/dev/null 2>&1
t_CheckExitStatus $?
