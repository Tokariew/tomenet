#!/bin/sh
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

cd /srv/build
git clone https://github.com/TomenetGame/tomenet.git tomenet

cd tomenet/src

var1=$(git log -1 --pretty=format:'%cr')
num1=${var1%% *}

{ [ "$num1" -lt 7 ] && test "${var1#*days}" != "$var1"; } || { cleanup && echo "Old version" && exit 0; }

patch "$@" || (cleanup && exit 0)
patch fedora.patch || (cleanup && exit 0)

echo "compiling"

cpus="$(nproc)"
make -s -j"$cpus" -f makefile.mingw tomenet.server.exe
mingw-strip tomenet.server.exe
mv tomenet.server.exe ..
cd /srv/build/tomenet
cp /usr/i686-w64-mingw32/sys-root/mingw/bin/libssp-0.dll .
7z a -t7z -mx=9 ../tomenet-"$(date --iso-8601)".7z COPYING .tomenetrc lib/ tomenet.server.exe libssp-0.dll
cleanup
