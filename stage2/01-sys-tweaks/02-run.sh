
on_chroot << EOF
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker pi
EOF

on_chroot << EOF
apt-get -y install python3-pip
pip3 install docker-compose
EOF

on_chroot << EOF
cd /home/pi && mkdir signalk && cd signalk && curl -fsSL  https://api.github.com/repos/tkurki/signalk-server-docker-setup/tarball | tar xz --strip-components=1
EOF
