
on_chroot << EOF
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker pi
EOF

on_chroot << EOF
apt-get -y install python3-pip
pip3 install docker-compose
EOF

echo `which install`

install -m 644 files/signalk-docker-compose.service ${ROOTFS_DIR}/etc/systemd/system/signalk-docker-compose.service
mkdir ${ROOTFS_DIR}/etc/signalk-docker-compose
install -m 644 files/docker-compose.yml ${ROOTFS_DIR}/etc/signalk-docker-compose/docker-compose.yml
install -m 644 files/docker-compose.env "${ROOTFS_DIR}/etc/signalk-docker-compose/.env"

install -v -d "${ROOTFS_DIR}/home/pi/signalk-docker-data"
install -v -d -o 999 -g 999 "${ROOTFS_DIR}/home/pi/signalk-docker-data/logs"
install -v -d "${ROOTFS_DIR}/home/pi/signalk-docker-data/influxdb"
install -v -d "${ROOTFS_DIR}/home/pi/signalk-docker-data/grafana"

install -v -d "${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data"
install -m 644 files/dotsignalk/package.json ${ROOTFS_DIR}/home/pi/.signalk/package.json
install -m 644 files/dotsignalk/settings.json ${ROOTFS_DIR}/home/pi/.signalk/settings.json
chown -R 999:999 ${ROOTFS_DIR}/home/pi/.signalk/
install -v -d "${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data"
install -m 644 files/dotsignalk/plugin-config-data/signalk-to-influxdb.json ${ROOTFS_DIR}/home/pi/.signalk/plugin-config-data/signalk-to-influxdb.json

on_chroot << EOF
systemctl enable signalk-docker-compose
EOF
