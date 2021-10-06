#!/bin/sh

t_Log "Running $0 - mysqld client can talk to mysql55 server."

if [ $el_ver -gt 5 ]
then
  t_Log 'mysql55 is only avialable on C5, skipping'
  t_CheckExitStatus 0       
  exit 0
fi

HostName=$(hostname -s)
MySqlHostName=$(mysql -N -B -u root -e "show variables like 'hostname'" | cut -f 2 | cut -d . -f 1)
if [ $HostName = ${MySqlHostName} ]; then
	ret_val=0
else
	ret_val=1
fi
t_CheckExitStatus $ret_val

t_Log "Running $0 - mysqld listening test."
grep 'skip-networking' /etc/my.cnf > /dev/null
if [ $? -eq 1 ]; then
	# FIXME: Test is very basic
	nc -d -w 1 localhost 3306 >/dev/null 2>&1
	t_CheckExitStatus $?
else
	t_Log "Skipped, looks like networking is disabled for mysql"
fi
