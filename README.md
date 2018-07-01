### Machine Translation English - Ashaninka 

#### Installing lttoolbox

In order to run this lexica you need to install LtToolbox (http://wiki.apertium.org/wiki/Lttoolbox), you can download the latest version of LtToolbox here:

https://sourceforge.net/projects/apertium/files/lttoolbox/


```
$ wget https://razaoinfo.dl.sourceforge.net/project/apertium/lttoolbox/3.3/lttoolbox-3.3.3.tar.gz
$ tar -zxvf lttoolbox-3.3.3.tar.gz
$ cd lttoolbox-3.3.3
$ ./configure
$ make
$ make check
$ sudo make install
$ cd ..
$ lt-comp lr en-cni.dix en-cni.bin
$ echo "grass" | lt-proc en-cni.bin
^grass/*grass$
```

#### Installing MATXIN

```
$ wget https://github.com/hinantin/squoia/blob/master/MT_systems/matxin-lex/squoia_xfer_lex.cc
$ g++ -std=gnu++0x -c -o squoia_xfer_lex.o squoia_xfer_lex.cc -I/usr/local/include/lttoolbox-3.3 -I/usr/local/lib/lttoolbox-3.3/include -I/usr/include/libxml2
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
$ g++ -O3 -Wall -o squoia_xfer_lex squoia_xfer_lex.o -L/usr/local/lib -llttoolbox3 -lxml2 -lpcre
```

#### Installing Freeling 

```
$ git clone https://github.com/TALP-UPC/FreeLing
# Getting cmake >= 3.7 in Ubuntu 16.04 
$ wget https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.tar.gz
$ sudo apt-get install libboost-filesystem-dev
$ sudo apt-get install libboost-iostreams-dev
$ cd Freeling 

```
