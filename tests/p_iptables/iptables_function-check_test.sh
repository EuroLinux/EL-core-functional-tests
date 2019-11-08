#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
#         Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - iptables functional check - deny ping on loopback"

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


ACL='INPUT -s 127.0.0.1/32 -d 127.0.0.1/32 -p icmp -m icmp -j REJECT'
COUNT='4'
DEADTIME='1'

# ensure we have the default iptables-setting
/etc/init.d/iptables restart > /dev/null

# Verify it worked previously
ping -q -c $COUNT -i 0.25 127.0.0.1 |grep -qc "${COUNT} received"

if [ $? == 1 ]
  then
  t_Log "ping to loopback failed prior to test, this should not happen"
  t_CheckExitStatus 1
fi

# Applying ACL
iptables -I ${ACL}

ping -q -c $COUNT -i 0.25 -w $DEADTIME 127.0.0.1 > /dev/null 2>&1
if [ $? == 1 ]
  then
  t_Log "iptables REJECT works fine"
  ret_val=0
else
  ret_val=1
fi

# cleanup
/etc/init.d/iptables restart > /dev/null

t_CheckExitStatus $ret_val

