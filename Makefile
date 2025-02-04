INAME = main
ONAME = fimp
IJ_INAME = main-ijcai
IJ_ONAME = fimp-ijcai
TEX_OPTIONS = -cnf-line "max_print_line = 10000" -halt-on-error
default:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
	bibtex $(ONAME).aux
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) $(INAME).tex
once-sepia:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{sepia}\input{$(INAME).tex}"
once-dark:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{dark}\input{$(INAME).tex}"
once-light:
	pdflatex $(TEX_OPTIONS) -jobname=$(ONAME) "\def\colorscheme{light}\input{$(INAME).tex}"
ijcai:
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) $(IJ_INAME).tex
	bibtex $(IJ_ONAME).aux
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) $(IJ_INAME).tex
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) $(IJ_INAME).tex
once-ijcai-sepia:
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) "\def\colorscheme{sepia}\input{$(IJ_INAME).tex}"
once-ijcai-dark:
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) "\def\colorscheme{dark}\input{$(IJ_INAME).tex}"
once-ijcai-light:
	pdflatex $(TEX_OPTIONS) -jobname=$(IJ_ONAME) "\def\colorscheme{light}\input{$(IJ_INAME).tex}"
clean:
	rm -f *.{aux,bbl,blg,log,out,toc,vtc,cut}
arxiv:
	mkdir -p arxiv
	cp -r figs dags arxiv
	cp $(ONAME).bbl arxiv/$(ONAME)-final.bbl
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME).tex --bbl-to-link $(ONAME)-final.bbl -o arxiv/$(ONAME)-final.tex
	@echo "Now cd to arxiv and run 'pdflatex $(ONAME)-final.tex' thrice."
arxiv.zip: arxiv
	cd arxiv && zip -r ../arxiv.zip . -x '.*' -x '*.db' -x '__MACOSX'
