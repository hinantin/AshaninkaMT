# deprecated 
extractbilingualvocab:
	@cat en-cni.dix.part1
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/vroot.prq.foma --file ../AshaninkaMorph/oroot.prq.foma --file ../AshaninkaMorph/neg.prq.foma 
	@cat en-cni.dix.part2
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/nroot.prq.foma --label "@section:noun@" --rootlabel "NRoot" --section "Noun" 
	@cat en-cni.dix.part3

enbilingualvocab:
	@cp en-cni.base.dix en-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/prnposs.prq.foma --label "@section:prnposs@" --rootlabel "PrnPoss" --section "Possessive_pronoun" > file1
	@sed -i -e '/POINTERPRNPOSS/r file1' en-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/vroot.prq.foma --file ../AshaninkaMorph/oroot.prq.foma --file ../AshaninkaMorph/neg.prq.foma > file1
	@sed -i -e '/POINTERVROOT/r file1' en-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/nroot.prq.foma --label "@section:noun@" --rootlabel "NRoot" --section "Noun" > file1
	@sed -i -e '/POINTERNROOT/r file1' en-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/prnpers.prq.foma --label "@section:prnpers@" --rootlabel "PrnPers" --section "Personal_pronouns" > file1
	@sed -i -e '/POINTERPRNPERS/r file1' en-cni.dix 

bilingualvocab:
	@cp en-cni.base.dix es-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/vroot.prq.foma --label "@section:verb@" --rootlabel "VRoot" --section "Verb" --language "ES" > file1
	@sed -i -e '/POINTERVROOT/r file1' es-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/nroot.prq.foma --label "@section:noun@" --rootlabel "NRoot" --section "Noun" --language "ES" > file1
	@sed -i -e '/POINTERNROOT/r file1' es-cni.dix 
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/nroot.prq.foma --label "@section:noun@" --rootlabel "NRoot" --section "Noun" --language "PT" > pt-cni.dix
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/nroot.prq.foma --label "@section:noun@" --rootlabel "NRoot" --section "Noun" --language "QU" > qu-cni.dix    

compile:
	@sudo cp freeling/en/locucions.dat /usr/local/share/freeling/en/locucions.dat 
	@sudo cp freeling/en/dicc.src /usr/local/share/freeling/en/dicc.src 
	@rm -f es-cni.bin
	@lt-comp lr es-cni.dix es-cni.bin
	@echo "pedregal" | lt-proc es-cni.bin
	@echo "cascajal" | lt-proc es-cni.bin
	@echo "cosho" | lt-proc es-cni.bin
	@rm -f en-cni.bin
	@lt-comp lr en-cni.dix en-cni.bin
	@echo "grass" | lt-proc en-cni.bin
	@echo "herb" | lt-proc en-cni.bin
	@echo "tree" | lt-proc en-cni.bin
	@echo "fat" | lt-proc en-cni.bin
	@echo "stick" | lt-proc en-cni.bin
	@echo "to_hunt" | lt-proc en-cni.bin
	@echo "but" | lt-proc en-cni.bin
	@lt-comp lr prq.monodix prq-monodix.bin
	@cp /usr/local/share/freeling/pt/locucions.dat freeling/pt




