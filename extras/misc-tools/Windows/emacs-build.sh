target=/c/emacs

export PATH=/mingw64/bin:$PATH
 
mkdir build; cd build

./autogen.sh
./configure --with-json --with-modules --with-harfbuzz --with-compress-install \
            --with-threads --with-included-regex --with-zlib --with-sound \
            --with-xpm --with-jpeg --with-tiff --with-gif --with-png \
            --with-rsvg --with-imagemagick  --with-toolkit-scroll-bars \
            --without-gpm --without-dbus \
            --with-mailutils --with-gsettings --with-pop --with-xml2 --with-native-compilation \
            --host=x86_64-w64-mingw32 \
            --target=x86_64-w64-mingw32 \
            --build=x86_64-w64-mingw32 \
            --with-wide-int \
            prefix=$target
make
make install prefix=$target

cp /mingw64/bin/*.dll $target