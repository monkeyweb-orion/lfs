#!/bin/bash
set -e
echo "Setup general network configuration.."

# 9.5.1 create a sample file for the wlp3s0 device with a static IP address
# TODO make params configurable
cd /etc/sysconfig/
cat > ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=192.168.1.2
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF

# 9.5.2. Creating the /etc/resolv.conf File
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
# End /etc/resolv.conf
EOF

# 9.5.3. Configuring the system hostname
echo "lfs" > /etc/hostname

# 7.5.4 customize /etc/hosts file
# TODO values need to be changed for specific uses or requirements
cat > /etc/hosts <<"EOF"
127.0.0.1 localhost
# 127.0.1.1 <FQDN> <HOSTNAME>
# <192.168.1.1> <FQDN> <HOSTNAME> [alias1] [alias2 ...]
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF