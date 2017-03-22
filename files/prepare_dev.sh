#1/bin/sh
set -efux

PREFIX=${HOME}/.local
BINDIR=${HOME}/bin
SRCDIR=${HOME}/src

GIT_NAME='nobody'
GIT_EMAIL='nobody@example.com'

main() {
    mkdir -p ${PREFIX}
    mkdir -p ${BINDIR}
    mkdir -p ${SRCDIR}
    install_repo
    install_fuseext2
    install_apv
    configure_git
}

install_repo() {
    REPO_URI=https://storage.googleapis.com/git-repo-downloads/repo
    curl -fsLS ${REPO_URI} > ${BINDIR}/repo
    chmod u+x ${HOME}/bin/repo
}

install_fuseext2() {
    (
        cd ${SRCDIR}
        git clone https://github.com/alperakcan/fuse-ext2.git
        cd fuse-ext2
        ./autogen.sh
        ./configure --prefix=${PREFIX}
        make -j
        make install
        ln -s ${PREFIX}/bin/fuse-ext2 ${BINDIR}
    )
}

install_apv() {
    git clone https://github.com/anestisb/android-prepare-vendor.git \
              ${SRCDIR}/android-prepare-vendor
}

configure_git() {
    git config --global user.email "${GIT_EMAIL}"
    git config --global user.name "${GIT_NAME}"
}

main
