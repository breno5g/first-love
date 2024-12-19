#!/bin/bash

NAME=$(grep -oP '(?<=name = ").*?(?=")' makelove.toml)
LOVE_VERSION=$(grep -oP '(?<=version = ").*?(?=")' makelove.toml)
LOVE_URL=https://github.com/love2d/love/releases/download/$LOVE_VERSION/love-$LOVE_VERSION-x86_64.AppImage
zip -9 -r $NAME.love .
wget $LOVE_URL -O love.AppImage
chmod +x love.AppImage
./love.AppImage --appimage-extract
cat ./squashfs-root/bin/love $NAME.love > ./squashfs-root/bin/$NAME
chmod +x ./squashfs-root/bin/$NAME
rm -rf ./squashfs-root/bin/love
mv ./squashfs-root/bin/$NAME ./squashfs-root/bin/love

appimagetool ./squashfs-root $NAME.AppImage