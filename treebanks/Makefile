compile:
	@awk 'FNR==1{print ""}{print}' cushimarianoprel08_*.conll > cushimarianoprel08.conll

download:
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20171215_cushimarianoprel08.xml > parallel_texts_20171215_cushimarianoprel08.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180307_minagrihidrico13.xml > parallel_texts_20180307_minagrihidrico13.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180623_mihasanaani11.xml > parallel_texts_20180623_mihasanaani11.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180624_mihastransformador11.xml > parallel_texts_20180624_mihastransformador11.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_homapani.xml > parallel_texts_homapani.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180428_almonacid2minedu15.xml > parallel_texts_20180428_almonacid2minedu15.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180505_mesquitaetnomatematica12.xml > parallel_texts_20180505_mesquitaetnomatematica12.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180505_apiwtxagestao07.xml > parallel_texts_20180505_apiwtxagestao07.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20170728_mendozatarapoto17.xml > parallel_texts_20170728_mendozatarapoto17.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20180828_suarezhistorias04.xml > parallel_texts_20180828_suarezhistorias04.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts_20190305_notempodoverao.xml > parallel_texts_20190305_notempodoverao.xml
	@perl /home/hinantin/ashaninka/DependencyTreebanks/httpclient.pl -g /db/HNTAshaninka/ParallelCorpus/parallel_texts.xsd > parallel_texts.xsd
#	@sed -i '1s/^/<?xml version="1.0" encoding="UTF-8"?>\n/' parallel_texts_20171215_cushimarianoprel08.xml

cushimarianoprel08:
	@perl function_saveparsing.pl --parsing=cushimarianoprel08_2.conll --lang=cni --textid=2 --paralleltext=parallel_texts_20171215_cushimarianoprel08
	@make download;  git commit -a -m "Adding stuff."; git push -u origin master

