compile:
	@awk 'FNR==1{print ""}{print}' cushimarianoprel08_*.conll > cushimarianoprel08.conll

download:
	@perl /home/richard/Documents/git/02_AshaninkaMorph_GoogleCode/hntAshaninka/morphology/AshaninkaMorph/generated_states_transitions/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20171215_cushimarianoprel08.xml > parallel_texts_20171215_cushimarianoprel08.xml
	@perl /home/richard/Documents/git/02_AshaninkaMorph_GoogleCode/hntAshaninka/morphology/AshaninkaMorph/generated_states_transitions/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180307_minagrihidrico13.xml > parallel_texts_20180307_minagrihidrico13.xml
	@perl /home/richard/Documents/git/02_AshaninkaMorph_GoogleCode/hntAshaninka/morphology/AshaninkaMorph/generated_states_transitions/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts.xsd > parallel_texts.xsd
#	@sed -i '1s/^/<?xml version="1.0" encoding="UTF-8"?>\n/' parallel_texts_20171215_cushimarianoprel08.xml

cushimarianoprel08:
	@perl function_saveparsing.pl --parsing=cushimarianoprel08_2.conll --lang=cni --textid=2 --paralleltext=parallel_texts_20171215_cushimarianoprel08
	@make download;  git commit -a -m "Adding stuff."; git push -u origin master

