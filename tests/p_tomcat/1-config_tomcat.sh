#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>
if [ "$el_ver" -ge "8" ] ; then
   exit 0
fi
uname_arch=$(uname -m)

t_Log "$0 - Configuring Tomcat"

if [ "$el_ver" = "7" ] ;then
   TOMCAT_SRV_NAME=tomcat
   TOMCAT_CONF_DIR=/etc/tomcat/
elif [ "$el_ver" = "6" ] ; then
   TOMCAT_SRV_NAME=tomcat6
   TOMCAT_CONF_DIR=/etc/tomcat6/
else
   TOMCAT_SRV_NAME=tomcat5
   TOMCAT_CONF_DIR=/etc/tomcat5/
fi

if [ "$el_ver" = "7" ] ;then
  sed -i 's/<\/tomcat-users>/<user username="admin" password="admin" roles="admin,manager,admin-gui,manager-gui"\/>\n<\/tomcat-users>/' $TOMCAT_CONF_DIR/tomcat-users.xml 
else
  sed -i 's/<\/tomcat-users>/<user username="admin" password="admin" roles="admin,manager"\/>\n<\/tomcat-users>/' $TOMCAT_CONF_DIR/tomcat-users.xml 
fi

service $TOMCAT_SRV_NAME restart

# we need extra sec for tomcat (and even more time for armhfp)
if [ "$uname_arch" == "armv7l" ] ; then
  sleep_time="300"
else
  sleep_time="10"
fi

t_Log "Sleeping $sleep_time seconds for $uname_arch"
sleep $sleep_time
