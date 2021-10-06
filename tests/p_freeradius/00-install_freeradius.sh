#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

# Install freeradius
# C6 comes with freeradius2
# C7 comes with freeradius3

t_Log "Running $0 - installation and startup of freeradius."

t_InstallPackage freeradius freeradius-utils

# start daemon with default settings
if [ $el_ver -gt 5 ]
then
  t_ServiceControl radiusd start
else
  # C5 has an eap-setting in radiusd.conf and 3 "sites-enabled" which prevent successfull start (probably missing some dep)
  # as the basic test works without these, the eap settings and 2 sites-enabled will be removed for the test and later restored
  # Check if we allready did this
  if [ ! -e /etc/raddb/radiusd.conf.orig ]
    then
    # File not yet copied
    /bin/cp -a /etc/raddb/radiusd.conf /etc/raddb/radiusd.conf.orig
    grep -iv eap /etc/raddb/radiusd.conf.orig > /etc/raddb/radiusd.conf
  fi
  rm -rf /etc/raddb/sites-enabled/control-socket
  rm -rf /etc/raddb/sites-enabled/inner-tunnel
  # /etc/raddb/sites-configured will be changed to include only basic files-authentication
  # Check if we allready did this
  if [ ! -e /etc/raddb/sites-available/default.orig ]
    then
    # File not yet copied
    /bin/cp -a /etc/raddb/sites-available/default /etc/raddb/sites-available/default.orig
  fi
cat > /etc/raddb/sites-available/default <<EOF
authorize {
        files
}
authenticate {
}
EOF
fi

