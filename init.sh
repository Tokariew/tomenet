#!/bin/bash
# shellcheck disable=SC2164

cleanup(){ \
  cd /srv/build
  rm -rf tomenet
}

patch(){ \
  for p in "$@"
  do
       cp /patches/"$p" /srv/build/tomenet/src
       echo patching with "$p"
       git apply "$p" || return 1
       echo patching passed
   done
}

timecheck(){ \
  var1=$(git log -1 --pretty=format:'%ct')
  num1=$(date '+%s')
  ((diff=num1-var1))
  # old version should not be older than one week and one hour
  # more robust
  [ "$diff" -lt 605700 ] || return 1
}

cd /srv/build
git clone https://github.com/TomenetGame/tomenet.git tomenet

cd tomenet/src

while getopts ":t" opts
do
  case "$opts" in
    (t) timecheck || { echo "old version" && cleanup && exit 0; } ;;
  esac
done

#getopts will fail silently on first patch, substraction move to correct position
OPTIND=$((OPTIND-1))
shift "$OPTIND"

patch "$@" || (cleanup && exit 0)
patch fedora.patch || (cleanup && exit 0)

echo "compiling"

cpus="$(nproc)"
make -s -j"$cpus" -f makefile.mingw tomenet.server.exe
mingw-strip tomenet.server.exe
mv tomenet.server.exe ..
cd /srv/build/tomenet
cp /usr/i686-w64-mingw32/sys-root/mingw/bin/libssp-0.dll .
cp /usr/i686-w64-mingw32/sys-root/mingw/bin/libgnurx-0.dll .
7z a -t7z -mx=9 ../tomenet-"$(date --iso-8601)".7z COPYING .tomenetrc lib/ tomenet.server.exe libssp-0.dll libgnurx-0.dll
cleanup
