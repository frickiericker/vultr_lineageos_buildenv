#!/bin/sh
set -efux

LINEAGEOS_GIT=https://github.com/LineageOS/android.git
VERSION=14.1
BRANCH=cm-${VERSION}

DIR=${HOME}/android/lineage-${VERSION}
mkdir -p ${DIR}
cd ${DIR}

repo init -u ${LINEAGEOS_GIT} -b ${BRANCH}
repo sync
