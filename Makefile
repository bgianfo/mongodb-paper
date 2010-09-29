LATEX=latex
CONVERT_DVI=dvipdf

default: mongo-paper

open: 
	open mongo-paper.pdf

mongo-paper: mongo-paper.tex
	$(LATEX) mongo-paper.tex
	$(LATEX) mongo-paper.tex
	$(CONVERT_DVI) mongo-paper.dvi
	rm -rf mongo-paper.log
	rm -rf mongo-paper.aux
	rm -rf mongo-paper.dvi

paper-clean:
	rm -f mongo-paper.dvi
	rm -f mongo-paper.aux
	rm -f mongo-paper.log
	rm -f mongo-paper.pdf
	rm -f mongo-paper.toc

# Check style:
proof:
	@echo "weasel words: "
	@./bin/weasel *.tex
	@echo
	@echo "passive voice: "
	./bin/passive *.tex
	@echo
	@echo "duplicates: "
	./bin/dups *.tex

detex:
	@detex mongo-paper.tex > .detex


diction: detex
	diction -L en -b -s .detex | fmt

style: detex
	style -n -N .detex | fmt

rmdetex: style diction
	@rm .detex
	


spell:
	aspell check -t mongo-paper.tex

clean: paper-clean
