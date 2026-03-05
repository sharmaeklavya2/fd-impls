INAME = main
ONAME = fimp
TEX_OPTIONS = -cnf-line "max_print_line = 10000" -halt-on-error
default:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
	bibtex $(ONAME).aux
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
clean:
	rm -f *.{aux,bbl,blg,log,out,toc,vtc,cut}
once-sepia:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{sepia}\input{$(INAME).tex}"
once-dark:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{dark}\input{$(INAME).tex}"
once-light:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{light}\input{$(INAME).tex}"
bib:
	bibtex $(ONAME).aux
ijcai:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai $(INAME)-ijcai.tex
	bibtex $(ONAME)-ijcai.aux
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai $(INAME)-ijcai.tex
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai $(INAME)-ijcai.tex
once-sepia-ijcai:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai "\def\colorscheme{sepia}\input{$(INAME)-ijcai.tex}"
once-dark-ijcai:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai "\def\colorscheme{dark}\input{$(INAME)-ijcai.tex}"
once-light-ijcai:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-ijcai "\def\colorscheme{light}\input{$(INAME)-ijcai.tex}"
bib-ijcai:
	bibtex $(ONAME)-ijcai.aux
neurips:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips $(INAME)-neurips.tex
	bibtex $(ONAME)-neurips.aux
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips $(INAME)-neurips.tex
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips $(INAME)-neurips.tex
once-sepia-neurips:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips "\def\colorscheme{sepia}\input{$(INAME)-neurips.tex}"
once-dark-neurips:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips "\def\colorscheme{dark}\input{$(INAME)-neurips.tex}"
once-light-neurips:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-neurips "\def\colorscheme{light}\input{$(INAME)-neurips.tex}"
bib-neurips:
	bibtex $(ONAME)-neurips.aux
aamas:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas $(INAME)-aamas.tex
	bibtex $(ONAME)-aamas.aux
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas $(INAME)-aamas.tex
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas $(INAME)-aamas.tex
once-sepia-aamas:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas "\def\colorscheme{sepia}\input{$(INAME)-aamas.tex}"
once-dark-aamas:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas "\def\colorscheme{dark}\input{$(INAME)-aamas.tex}"
once-light-aamas:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)-aamas "\def\colorscheme{light}\input{$(INAME)-aamas.tex}"
bib-aamas:
	bibtex $(ONAME)-aamas.aux
	mv $(ONAME)-aamas.bbl $(ONAME)-aamas-orig.bbl
	perl -pe 's/(\\bibitem\[\\protect\\citeauthoryear\{Conitzer)/\\balance\n$$1/' $(ONAME)-aamas-orig.bbl > $(ONAME)-aamas.bbl
arxiv:
	mkdir -p arxiv
	cp -r figs dags arxiv
	cp $(ONAME).bbl arxiv/$(ONAME)-final.bbl
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME).tex --bbl-to-link $(ONAME)-final.bbl -o arxiv/$(ONAME)-final.tex
	@echo "Now cd to arxiv and run 'pdflatex $(ONAME)-final.tex' thrice."
arxiv.zip: arxiv
	cd arxiv && zip -r ../arxiv.zip . -x '.*' -x '*.db' -x '__MACOSX'
camred:
	mkdir -p camred
	cp -r figs dags camred
	cp aamas.cls by.pdf camred
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME)-aamas.tex --bbl-to-read $(ONAME)-aamas.bbl -o camred/$(ONAME)-aamas-final.tex
	@echo "Now cd to camred and run 'pdflatex $(ONAME)-aamas-final.tex' thrice."
camred.zip: camred
	cd camred && zip -r ../camred.zip . -x '.*' -x '*.db' -x '__MACOSX'
