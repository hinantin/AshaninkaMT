extractbilingualvocab:
	@cat en-cni.dix.part1
	@perl convertFsttoLttoolbox.pl --file ../AshaninkaMorph/vroot.prq.foma --file ../AshaninkaMorph/oroot.prq.foma --file neg.prq.foma 
	@cat en-cni.dix.part2

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




