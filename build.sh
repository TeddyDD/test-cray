#!/bin/sh
dir=$(pwd)
project="test-cray"
mkdir -p obj
crystal build --release --no-debug --cross-compile --target "x86_64-unknown-linux-gnu" src/${project}.cr -o obj/${project} > /dev/null

LINK="-L/usr/lib -L/usr/local/lib -L/usr/local/lib64"
INCLUDE="-I/usr/local/include -I${dir}/lib/cray_raygui/src/cray_raygui"
AFILES="/usr/lib/crystal/ext/libcrystal.a ${dir}/lib/cray_raygui/src/cray_raygui/raygui.o"
STATIC="-levent -lpcre -lssl -lgc -lcrypto -lz -lraylib"
DYNAMIC="-ldl -lrt -lpthread -lc -lm -lX11"
cc -O3 -rdynamic -fPIC "obj/${project}.o" -o "bin/${project}"  ${INCLUDE} ${LINK} ${AFILES}  -Wl,-Bstatic ${STATIC}  -Wl,-Bdynamic ${DYNAMIC}
strip bin/${project}
rm -r obj
