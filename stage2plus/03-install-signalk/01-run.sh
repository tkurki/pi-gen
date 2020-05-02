#!/bin/bash -e

#config sk
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.signalk/plugin-config-data"
install -m 644 -o 1000 -g 1000 files/set-system-time.json		"${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.signalk/plugin-config-data/"

#install sk server and default plugins
on_chroot << EOF
cd /home/${FIRST_USER_NAME}/.signalk
npm install -g --unsafe-perm signalk-server
npm i --production --verbose signalk-to-nmea2000
npm i --production --verbose signalk-n2kais-to-nmea0183
chown -R ${FIRST_USER_NAME} /home/${FIRST_USER_NAME}/.signalk
EOF
