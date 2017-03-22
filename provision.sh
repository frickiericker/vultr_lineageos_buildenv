#!/bin/sh
set -efu

UPDATE_ATTEMPTS=10

LOG() {
    echo "+ $*"
    "$@" > /dev/null
}

main() {
    export DEBIAN_FRONTEND=noninteractive
    update_packages
    install_utilities
    install_build_requirements
    configure
    echo 'Done.'
}

#
# Upgrade installed packages. This may occasionally fail on Vultr[1].
#
# [1]: https://www.vultr.com/docs/automating-ubuntu-16-updates-with-vultr-startup-scripts
#
update_packages() {
    do_aptget_update
    do_aptget_upgrade
}

do_aptget_update() {
    for i in $(seq ${UPDATE_ATTEMPTS}); do
        LOG apt-get update && return
        sleep 2
    done
    echo 'Update failed. Proceeding anyway...' >&2
}

do_aptget_upgrade() {
    for i in $(seq ${UPDATE_ATTEMPTS}); do
        LOG apt-get -y upgrade && return
        sleep 2
    done
    echo 'Upgrade failed. Proceeding anyway...' >&2
}

#
# Install fundamental packages.
#
install_utilities() {
    LOG apt-get install -y mosh tmux htop vim
}

#
# Install packages that are required to build a LineageOS ROM.
#
install_build_requirements() {
    # From LineageOS wiki.
    LOG apt-get install -y bc bison build-essential curl flex g++-multilib     \
                           gcc-multilib git gnupg gperf imagemagick            \
                           lib32ncurses5-dev lib32readline6-dev lib32z1-dev    \
                           libesd0-dev liblz4-tool libncurses5-dev             \
                           libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils \
                           lzop libssl-dev pngcrush rsync schedtool            \
                           squashfs-tools xsltproc zip zlib1g-dev

    # For LineageOS 14.1.
    LOG apt-get install -y openjdk-8-jdk

    # For repo.
    LOG apt-get install -y git gnupg python python-kerberos

    # For android-prepare-vendor.
    LOG apt-get install -y fuse unzip wget

    # For fuse-ext2.
    LOG apt-get install -y m4 autoconf automake libtool libfuse-dev e2fsprogs  \
                           comerr-dev e2fslibs-dev
}

#
# Tweak configuration files.
#
configure() {
    # Required for non-super user to run fusermount.
    LOG sed -i '/user_allow_other/ s/^#//' /etc/fuse.conf
}

main
