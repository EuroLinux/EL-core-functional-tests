#!/bin/sh
# Author: Nikhil Lanjewar <nikhil@lanjewar.com>
# Author: Sahil Muthoo <sahilm@thoughtworks.com>
# Author: Sahil Aggarwal <sahilagg@gmail.com>
# Author: Saager Mhatre <saager.mhatre@gmail.com>
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - Check version of irb."

#allready prepared just in case versions should change between C5 and C6
if [ "$el_ver" = "7" -o "$el_ver" = "8" ] ; then
  irb -v | grep -q '0.9.6'
  ret_val=$?
else
  irb -v | grep -q '0.9.5'
  ret_val=$?
fi

t_CheckExitStatus $ret_val
