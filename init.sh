cd /srv/build
git clone https://github.com/Tokariew/tomenet.git tomenet
cd tomenet/src
git remote add upstream https://github.com/TomenetGame/tomenet.git
git pull upstream master
git checkout mingw
git merge --no-commit
make -j 13 -f makefile.mingw tomenet.server.exe
mingw-strip tomenet.server.exe
mv tomenet.server.exe ..
cd ..
7z a -t7z -mx=9 -mfb=273 -ms -myx=9 -mtm=- -mmt -mmtf -md=1536m -mmf=bt3 -mmc=10000 -mpb=0 -mlc=0 ../tomenet-$(date --iso-8601).7z COPYING .tomenetrc lib/ tomenet.server.exe
cd ..
rm -rf tomenet
