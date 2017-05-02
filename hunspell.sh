
#### https://taegon.kim/archives/2551


###. hunspell 
1. down 
https://github.com/hunspell/hunspell
2. install
autoreconf -vfi
./configure --prefix=/home/server/hunspell
make
mkae install
3. test

###. 한국어사전
1. down 
https://github.com/changwoo/hunspell-dict-ko/
2. python3 install 
# wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tgz
# ./configure --prefix=/home/server/python3 --enable-optimizations
# make
# make altinstall
# strip /home/server/python3/lib/libpython3.6m.so.1.0
3. pip설치  
# wget https://bootstrap.pypa.io/get-pip.py 
python3.6 get-pip.py
# /home/server/python3/bin/python --version



###. php_hunspell
1. down
https://github.com/taggon/php_hunspell
2. install
# /home/server/php7/bin/phpize
# ln -s /home/server/hunspell/lib/libhunspell-1.6.so /home/server/hunspell/lib/libhunspell.so
# ./configure --with-php-config=/home/server/php7/bin/php-config  --with-hunspell=/home/server/hunspell
# make
# make install

