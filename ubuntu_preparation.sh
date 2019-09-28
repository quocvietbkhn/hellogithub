#!/bin/bash
apt-get update
apt-get upgrade -y
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install -y vim sublime-text build-essential ibus-unikey openssh-server vlc git meld
cd ~/Downloads/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -y -f 
rm -f  google-chrome-stable_current_amd64.deb

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
dpkg -i teamviewer_amd64.deb
apt-get install -y -f 
rm -f  teamviewer_amd64.deb
apt-get -y autoremove

#petalinux 2015.4 required packages
apt-get install -y tofrodos iproute gawk gcc git-core make net-tools ncurses-dev libncurses5-dev  xinetd tftpd tftp zlib1g-dev flex bison lib32z1 lib32ncurses5 lib32stdc++6 libselinux1 
## TFTP setting
cat > /etc/xinetd.d/tftp <<EOF
service tftp
{
protocol        = udp
port            = 69
socket_type     = dgram
wait            = yes
user            = nobody
server          = /usr/sbin/in.tftpd
server_args     = /tftpboot
disable         = no
}
EOF

mkdir -p /tftpboot
chmod -R 777 /tftpboot
chown -R nobody /tftpboot
service xinetd restart
