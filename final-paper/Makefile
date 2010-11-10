LATEX=latex
BIBTEX=bibtex
CONVERT_DVI=dvipdf

BUILD_TYPE := $(shell uname)

ifeq ($(BUILD_TYPE), Darwin)
  VIEWER := open 
else
  VIEWER := evince 
endif

default: clean final-paper paper-clean

open:
	@echo $(BUILD_TYPE)
	$(VIEWER) final-paper.pdf

final-paper: final-paper.tex
	$(LATEX)  final-paper
	$(BIBTEX) final-paper
	$(LATEX)  final-paper
	$(LATEX)  final-paper
	$(CONVERT_DVI) final-paper.dvi
	$(VIEWER) final-paper.pdf

paper-clean:
	rm -f *.dvi
	rm -f *.aux
	rm -f *.log
	rm -f *.toc
	rm -rf *.bbl
	rm -rf *.blg
	rm -rf *.log

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
	@detex final-paper.tex > .detex


test:
	@echo $(shell uname)

diction: detex
	diction -L en -b -s .detex | fmt

style: detex
	style -n -N .detex | fmt

rmdetex: style diction
	@rm .detex

spell:
	aspell check -t final-paper.tex

clean: paper-clean
	rm -rf final-paper.pdf
