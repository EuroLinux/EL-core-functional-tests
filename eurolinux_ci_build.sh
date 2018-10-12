#!/bin/sh
# Build steps used in EuroLinux CI
setup_ip_tables(){
    sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
    sudo iptables -A INPUT -p icmp -j ACCEPT
    sudo iptables -A INPUT -i lo -j ACCEPT
    sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
    sudo iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
    sudo iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited
    sudo iptables-save | sudo tee /etc/sysconfig/iptables
    sudo service iptables restart 
}

correct_vagrant(){
    hash iptables 2> /dev/null && setup_ip_tables
}

# correct vagrant enviroment
correct_vagrant

sudo yum -y update
uname -a
#sudo SKIP_QA_HARNESS=1 ./runtests.sh
sudo ./runtests.sh
