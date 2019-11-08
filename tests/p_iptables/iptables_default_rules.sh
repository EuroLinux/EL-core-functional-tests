#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - check iptables default rules"

<<<<<<< HEAD
if [ "$el_ver" = "7" ];then
 t_Log "CentOS $el_ver uses firewalld and not iptables -> SKIP"
=======
if [ "$centos_ver" = "7" ] || [ "$centos_ver" = "8" ];then
 t_Log "CentOS $centos_ver uses firewalld and not iptables -> SKIP"
>>>>>>> 91ec2259bdd19c2a1a3261e92d1c3df08fd6b6ce
 t_CheckExitStatus 0
 exit 0
fi

if [ $SKIP_QA_HARNESS -eq 1 ]; then
  echo "Skip, No standard firewall config ..."
else

(grep "state --state ESTABLISHED,RELATED -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT" /etc/sysconfig/iptables > /dev/null 2>&1 ) && \

(grep "REJECT --reject-with icmp-host-prohibited" /etc/sysconfig/iptables > /dev/null 2>&1 )

fi

t_CheckExitStatus $?

