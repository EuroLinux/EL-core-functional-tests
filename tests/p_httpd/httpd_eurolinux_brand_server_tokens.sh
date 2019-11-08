#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - httpd: centos branding / Server tokens value "

curl -sI http://localhost/ | grep "Server:\ Apache.*\ (EuroLinux)" > /dev/null 2>&1

t_CheckExitStatus $?
