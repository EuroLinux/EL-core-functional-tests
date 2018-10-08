#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - logwatch test."

if [ "$el_ver" = "7" ] ; then
 lw_options="--range Today"
else
 lw_options="--range Today --print"
fi

logwatch ${lw_options}| grep -q 'Logwatch End'

t_CheckExitStatus $?
