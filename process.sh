#!/bin/bash

export FREELINGSHARE=/usr/local/share/freeling
export LD_LIBRARY_PATH=/usr/local/lib
SPANISH=/usr/local/share/freeling/config

# sh process.sh myinput.txt myoutput.txt

INPUT=$1
OUTPUT=$2

gedit $INPUT 

/usr/local/bin/analyzer -f $SPANISH/es.cfg --phon <$INPUT >$OUTPUT

gedit $OUTPUT 


#/usr/local/bin/analyzer --server -p 9696 -f /usr/local/share/freeling/config/es.cfg --outlv dep --output conll

