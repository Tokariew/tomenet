cd /srv/build
git clone https://github.com/TomenetGame/tomenet.git tomenet
cp /fedora.patch /srv/build/tomenet/src/
cd tomenet/src
git apply fedora.patch
make -j 12 -f makefile.mingw tomenet.server.exe
mingw-strip tomenet.server.exe
mv tomenet.server.exe ..
cd ..
cp /usr/i686-w64-mingw32/sys-root/mingw/bin/libssp-0.dll .
7z a -t7z -mx=9 ../tomenet-$(date --iso-8601).7z COPYING .tomenetrc lib/ tomenet.server.exe libssp-0.dll
cd ..
rm -rf tomenet
