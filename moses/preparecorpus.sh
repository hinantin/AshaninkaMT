#!/bin/bash

export LC_ALL="en_US.UTF-8" 

PATH=/home/hinantin/ashaninka
/usr/bin/perl $PATH/search.pl > sentences.pan-ashaninka
/usr/bin/perl $PATH/search_es.pl > sentences.spanish

# ./bjam -a --with-cmph=/home/hinantin/ashaninka/cmph-2.0_install/
# Corpus Preparation

/usr/bin/perl $PATH/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en < sentences.pan-ashaninka > sentences.tok.pan-ashaninka
/usr/bin/perl $PATH/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en < sentences.spanish > sentences.tok.spanish 

/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/train-truecaser.perl --model truecase-model.pan-ashaninka --corpus sentences.tok.pan-ashaninka
/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/train-truecaser.perl --model truecase-model.spanish --corpus sentences.tok.spanish

/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/truecase.perl \
   --model truecase-model.pan-ashaninka \
   < sentences.tok.pan-ashaninka \
   > sentences.true.pan-ashaninka
/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/truecase.perl \
   --model truecase-model.spanish \
   < sentences.tok.spanish \
   > sentences.true.spanish

/usr/bin/perl $PATH/mosesdecoder/scripts/training/clean-corpus-n.perl \
    sentences.true pan-ashaninka spanish \
    sentences.clean 1 80

# Language Model Training
PATHKENLM=/home/hinantin/ashaninka/kenlm/build/bin
cd lm && $PATHKENLM/lmplz -o 5 --discount_fallback < ../sentences.true.pan-ashaninka > sentences.arpa.pan-ashaninka

# (cd lm && /home/hinantin/ashaninka/mosesdecoder/bin/build_binary sentences.arpa.pan-ashaninka sentences.blm.pan-ashaninka)
cd lm && $PATH/mosesdecoder/bin/build_binary sentences.arpa.pan-ashaninka sentences.blm.pan-ashaninka

# (cd lm && echo "tsamera ironyaaka aavakero mapipaye , anyeero otzishi ." | /home/hinantin/ashaninka/mosesdecoder/bin/query sentences.blm.pan-ashaninka)
cd lm && echo "tsamera ironyaaka aavakero mapipaye , anyeero otzishi ." | $PATH/mosesdecoder/bin/query sentences.blm.pan-ashaninka 

# Training the Translation System
cd working && /usr/bin/nohup nice /usr/bin/perl /home/hinantin/ashaninka/mosesdecoder/scripts/training/train-model.perl -root-dir train \
 -corpus /home/hinantin/ashaninka/AshaninkaMT/moses/sentences.clean \
 -f spanish -e pan-ashaninka -alignment grow-diag-final-and -reordering msd-bidirectional-fe \
 -lm 0:3:/home/hinantin/ashaninka/AshaninkaMT/moses/lm/sentences.blm.pan-ashaninka:8 \
 -external-bin-dir /home/hinantin/ashaninka/mosesdecoder/tools >& training.out &



