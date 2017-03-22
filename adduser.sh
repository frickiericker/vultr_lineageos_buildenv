#!/bin/sh
set -efu

REMOTE_USER=vultr
FILESDIR=/vagrant/files

LOG() {
    echo "+ $*"
    "$@" > /dev/null
}

main() {
    patch_skeleton
    add_remote_user ${REMOTE_USER}
}

patch_skeleton() {
    SKEL=/etc/skel
    LOG patch -d ${SKEL} -p3 -i ${FILESDIR}/skel-bashrc.patch || true
    LOG install -m 0640 ${FILESDIR}/.bashrc.local ${SKEL}
    LOG install -m 0640 ${FILESDIR}/.inputrc      ${SKEL}
    LOG install -m 0640 ${FILESDIR}/.tmux.conf    ${SKEL}
    LOG install -m 0640 ${FILESDIR}/.vimrc        ${SKEL}
}

add_remote_user() {
    USER_SUDOER=/etc/sudoers.d/10-$1
    USER_HOME=/home/$1
    USER_SHELL=/bin/bash
    AUTH_KEYS=${HOME}/.ssh/authorized_keys

    LOG useradd -mU -d ${USER_HOME} -s ${USER_SHELL} $1

    # Requred by fusermount.
    LOG groupadd -f fuse
    LOG usermod -aG fuse $1

    # Enable password-less sudo.
    echo "$1 ALL=(ALL) NOPASSWD: ALL" > ${USER_SUDOER}
    chmod 0440 ${USER_SUDOER}

    # Vagrant-vultr plugin inserts a ssh pubkey under /root/.ssh.
    LOG install -o $1 -g $1 -m 0700 -d           ${USER_HOME}/.ssh
    LOG install -o $1 -g $1 -m 0600 ${AUTH_KEYS} ${USER_HOME}/.ssh

    # Install utilities.
    LOG install -o $1 -g $1 -m 0750 ${FILESDIR}/init_lineage.sh ${USER_HOME}
    LOG install -o $1 -g $1 -m 0750 ${FILESDIR}/prepare_dev.sh  ${USER_HOME}
}

main
