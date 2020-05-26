#!/usr/bin/env bash
cd /home/hinantin/ashaninka/AshaninkaMT/moses/working/mert-work
/home/hinantin/ashaninka/mosesdecoder/bin/extractor --sctype BLEU --scconfig case:true  --scfile run1.scores.dat --ffile run1.features.dat -r /home/hinantin/ashaninka/AshaninkaMT/moses/corpus/sentences.test.true.pan-ashaninka -n run1.best100.out.gz
