#!/bin/bash
# en -> pan-ashaninka
# fr -> spanish
export LC_ALL="en_US.UTF-8" 

PATH=/home/hinantin/ashaninka
PATHCORPUS=/home/hinantin/ashaninka/AshaninkaMT/moses/corpus
/usr/bin/perl $PATHCORPUS/search.pl > $PATHCORPUS/sentences.test.pan-ashaninka
/usr/bin/perl $PATHCORPUS/search_es.pl > $PATHCORPUS/sentences.test.spanish

# Corpus Preparation

/usr/bin/perl $PATH/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en < $PATHCORPUS/sentences.test.pan-ashaninka > $PATHCORPUS/sentences.test.tok.pan-ashaninka
/usr/bin/perl $PATH/mosesdecoder/scripts/tokenizer/tokenizer.perl -l en < $PATHCORPUS/sentences.test.spanish > $PATHCORPUS/sentences.test.tok.spanish 

#/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/train-truecaser.perl --model truecase-model.pan-ashaninka --corpus sentences.tok.pan-ashaninka
#/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/train-truecaser.perl --model truecase-model.spanish --corpus sentences.tok.spanish

/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/truecase.perl \
   --model /home/hinantin/ashaninka/AshaninkaMT/moses/truecase-model.pan-ashaninka \
   < $PATHCORPUS/sentences.test.tok.pan-ashaninka \
   > $PATHCORPUS/sentences.test.true.pan-ashaninka
/usr/bin/perl $PATH/mosesdecoder/scripts/recaser/truecase.perl \
   --model /home/hinantin/ashaninka/AshaninkaMT/moses/truecase-model.spanish \
   < $PATHCORPUS/sentences.test.tok.spanish \
   > $PATHCORPUS/sentences.test.true.spanish

cd /home/hinantin/ashaninka/AshaninkaMT/moses/working && \
 /usr/bin/nohup nice /usr/bin/perl /home/hinantin/ashaninka/mosesdecoder/scripts/training/mert-moses.pl \
  /home/hinantin/ashaninka/AshaninkaMT/moses/corpus/sentences.test.true.spanish /home/hinantin/ashaninka/AshaninkaMT/moses/corpus/sentences.test.true.pan-ashaninka \
  /home/hinantin/ashaninka/mosesdecoder/bin/moses train/model/moses.ini --mertdir /home/hinantin/ashaninka/mosesdecoder/bin/ \
  &> mert.out &


cd /home/hinantin/ashaninka/AshaninkaMT/moses/working && \
 /usr/bin/nohup nice /usr/bin/perl /home/hinantin/ashaninka/mosesdecoder/scripts/training/mert-moses.pl \
  --input /home/hinantin/ashaninka/AshaninkaMT/moses/corpus/sentences.test.true.spanish \ 
  --refs /home/hinantin/ashaninka/AshaninkaMT/moses/corpus/sentences.test.true.pan-ashaninka \
  --decoder /home/hinantin/ashaninka/mosesdecoder/bin/moses \ 
  --config /home/hinantin/ashaninka/AshaninkaMT/moses/working/train/model/moses.ini \ 
  --mertdir /home/hinantin/ashaninka/mosesdecoder/bin/ \
  &> mert.out &

# Testing

# $PATH/mosesdecoder/bin/moses -f ~/working/mert-work/moses.ini
# /home/hinantin/ashaninka/mosesdecoder/bin/moses -f /home/hinantin/ashaninka/AshaninkaMT/moses/working/mert-work/run1.moses.ini
# /home/hinantin/ashaninka/mosesdecoder/bin/moses -f /home/hinantin/ashaninka/AshaninkaMT/moses/working/mert-work/run1.moses.ini

cd /home/hinantin/ashaninka/AshaninkaMT/moses/working && \
 /home/hinantin/ashaninka/mosesdecoder/bin/processPhraseTableMin \
   -in train/model/phrase-table.gz -nscores 4 \
   -out binarised-model/phrase-table
 /home/hinantin/ashaninka/mosesdecoder/bin/processLexicalTableMin \
   -in train/model/reordering-table.wbe-msd-bidirectional-fe.gz \
   -out binarised-model/reordering-table

# /home/hinantin/ashaninka/mosesdecoder/bin/moses -f /home/hinantin/ashaninka/AshaninkaMT/moses/working/binarised-model/moses.ini

# /home/hinantin/ashaninka/mosesdecoder/bin/moses -f /home/hinantin/ashaninka/AshaninkaMT/moses/working/binarised-model/moses.ini -i input-file 
