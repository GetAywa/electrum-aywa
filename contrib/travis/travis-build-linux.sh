#!/bin/bash
set -ev

if [[ -z $TRAVIS_TAG ]]; then
  echo TRAVIS_TAG unset, exiting
  exit 1
fi

BUILD_REPO_URL=https://github.com/akhavr/electrum-aywa.git

cd build

git clone --branch $TRAVIS_TAG $BUILD_REPO_URL electrum-aywa

docker run --rm \
    -v $(pwd):/opt \
    -w /opt/electrum-aywa \
    -t zebralucky/electrum-aywa-winebuild:Linux /opt/build_linux.sh

sudo find . -name '*.po' -delete
sudo find . -name '*.pot' -delete

export WINEARCH=win32
export WINEPREFIX=/root/.wine-32
export PYHOME=$WINEPREFIX/drive_c/Python34

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-aywa/:$WINEPREFIX/drive_c/electrum-aywa \
    -w /opt/electrum-aywa \
    -t zebralucky/electrum-aywa-winebuild:Wine /opt/build_wine.sh

export WINEARCH=win64
export WINEPREFIX=/root/.wine-64
export PYHOME=$WINEPREFIX/drive_c/Python34

docker run --rm \
    -e WINEARCH=$WINEARCH \
    -e WINEPREFIX=$WINEPREFIX \
    -e PYHOME=$PYHOME \
    -v $(pwd):/opt \
    -v $(pwd)/electrum-aywa/:$WINEPREFIX/drive_c/electrum-aywa \
    -w /opt/electrum-aywa \
    -t zebralucky/electrum-aywa-winebuild:Wine /opt/build_wine.sh
