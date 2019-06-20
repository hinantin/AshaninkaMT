### Machine Translation English - Ashaninka 

How to download this repository
===============

* Using `wget`
```
$ wget https://github.com/hinantin/AshaninkaMT/archive/master.zip 
```

* Cloning the repository
```
$ git clone https://github.com/hinantin/AshaninkaMT
```

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
 Update the instructions.

```
$ git clone https://github.com/TALP-UPC/FreeLing
# Getting cmake >= 3.7 in Ubuntu 16.04 
$ wget https://cmake.org/files/v3.11/cmake-3.11.4-Linux-x86_64.tar.gz
$ sudo apt-get install libboost-filesystem-dev
$ sudo apt-get install libboost-iostreams-dev
$ cd Freeling 

```

### Parsing 

Testing

```
$ export FREELINGSHARE=/usr/local/share/freeling
$ analyzer -f /usr/local/share/freeling/config/en.cfg --server --port 50005
SERVER: Analyzers loaded.

Launched server 1915 at port 50005

You can now analyze text with the following command:
  - From this computer: 
      analyzer_client 50005 <input.txt >output.txt
      analyzer_client localhost:50005 <input.txt >output.txt
  - From any other computer: 
      analyzer_client ip-172-31-10-215:50005 <input.txt >output.txt

Stop the server with: 
      analyze stop 1915

SERVER.DISPATCHER: Waiting for a free worker slot
SERVER.DISPATCHER: Waiting connections
SERVER.DISPATCHER: Connection established. Forked worker 1967.
SERVER.DISPATCHER: Waiting for a free worker slot

```

Running the service

```
$ sudo cp tcpServerAnalyze /etc/init.d
$ sudo chmod +x /etc/init.d/tcpServerAnalyze
$ sudo update-rc.d tcpServerAnalyze defaults
$ sudo etc/init.d/tcpServerAnalyze start 
```

XML support

```
$  sudo apt-get install libxml-libxml-perl 
```

