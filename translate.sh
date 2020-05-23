#!/bin/bash
FREELINGINSTALLPATH=/home/hinantin/FreeLing_install
MATXININSTALLPATH=/home/hinantin/squoia/MT_systems/matxin-lex
TEMPPATH=/tmp
export FREELINGSHARE=$FREELINGINSTALLPATH/share/freeling
export LD_LIBRARY_PATH=$FREELINGINSTALLPATH/lib
CONFIG=$FREELINGINSTALLPATH/share/freeling/config

# DEFAULT CONFIGURATION 
#export FREELINGSHARE=/usr/local/share/freeling
#export LD_LIBRARY_PATH=/usr/local/lib
#CONFIG=/usr/local/share/freeling/config

# sh process.sh myinput.txt myoutput.txt

INPUT=$TEMPPATH/myinput.txt
OUTPUT=$TEMPPATH/myoutput.txt

rm -f $INPUT $OUTPUT 

printf "$1" > $INPUT

$FREELINGINSTALLPATH/bin/analyzer_client localhost:50005 <$INPUT >$OUTPUT

#/usr/local/bin/analyzer_client

# cat $OUTPUT

perl conll2xml.pm $OUTPUT | $MATXININSTALLPATH/squoia_xfer_lex en-cni.bin

