LATEX=latex
BIBTEX=bibtex
CONVERT_DVI=dvipdf

default: clean mongo-paper paper-clean

open:
	open mongo-paper.pdf

mongo-paper: mongo-paper.tex
	$(LATEX) mongo-paper
	$(BIBTEX) mongo-paper
	$(LATEX) mongo-paper
	$(LATEX) mongo-paper
	$(CONVERT_DVI) mongo-paper.dvi
	open mongo-paper.pdf

paper-clean:
	rm -f mongo-paper.dvi
	rm -f mongo-paper.aux
	rm -f mongo-paper.log
	rm -f mongo-paper.toc
	rm -rf mongo-paper.bbl
	rm -rf mongo-paper.blg
	rm -rf missfont.log

# Check style:
proof:
	@echo "weasel words: "
	@./bin/weasel *.tex
	@echo ""
	@echo "duplicates: "
	./bin/dups *.tex
	@echo ""
	@echo "passive voice: "
	./bin/passive *.tex

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
	rm -rf mongo-paper.pdf
