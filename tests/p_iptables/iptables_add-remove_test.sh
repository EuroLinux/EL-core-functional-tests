#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - verify iptables can insert and delete rules"

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


ACL='INPUT -s 1.2.3.4/32 -d 5.6.7.8/32 -p tcp -m tcp --dport 22 -j ACCEPT'
FILE=/var/tmp/iptables_acl

# verify we are starting with default firewall
/etc/init.d/iptables restart > /dev/null

iptables -I ${ACL}
iptables-save > ${FILE}

# The ACL should be exactly at line 6 after "OUTPUT ACCEPT"
head -6 ${FILE} |tail -1 | grep -q "${ACL}"
add=$?

# removing ACL again
iptables -D ${ACL}
iptables-save > ${FILE}

# ACL should not be found
grep -cq "${ACL}" ${FILE}
del=$?

if [ $add==0 ] && [ $del==1 ]
  then
  ret_val=0
fi

t_CheckExitStatus $ret_val

# Cleaning up
/bin/rm ${FILE}
