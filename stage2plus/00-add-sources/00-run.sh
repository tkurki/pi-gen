#!/bin/bash -e

install -m 644 files/sk.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
install -m 644 files/sk "${ROOTFS_DIR}/etc/apt/preferences.d/"

on_chroot apt-key add - < files/nodesource.gpg.key
on_chroot << EOF
apt-get update
EOF
