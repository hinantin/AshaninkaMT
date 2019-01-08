#!/bin/bash

export FREELINGSHARE=/usr/local/share/freeling
export LD_LIBRARY_PATH=/usr/local/lib
CONFIG=/usr/local/share/freeling/config


# sh process.sh myinput.txt myoutput.txt

INPUT=myinput.txt
OUTPUT=myoutput.txt

rm -f $INPUT $OUTPUT 

printf "$1" > $INPUT

/usr/local/bin/analyzer_client localhost:50005 <$INPUT >$OUTPUT

#/usr/local/bin/analyzer_client

# cat $OUTPUT

perl conll2xml.pm $OUTPUT | /home/richard/Documents/squoia/MT_systems/bin/squoia_xfer_lex en-cni.bin



#/usr/local/bin/analyzer --server -p 9696 -f /usr/local/share/freeling/config/es.cfg --outlv dep --output conll
