INAME = main
ONAME = fimp
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
clean:
	rm -f *.{aux,bbl,blg,log,out,toc,vtc,cut}
