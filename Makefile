INAME = main
ONAME = fimp
TEX_OPTIONS = -cnf-line "max_print_line = 10000" -halt-on-error
ZIP_EXCLUDES = -x '.*' -x '*.db' -x '__MACOSX'

VENUE_SUFFIX = $(if $(VENUE),-$(VENUE))
ISPEC = $(if $(COLOR),"\def\colorscheme{$(COLOR)}\input{$(INAME)$(VENUE_SUFFIX).tex}",$(INAME)$(VENUE_SUFFIX).tex)
TEX_RUN = pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)$(VENUE_SUFFIX) $(ISPEC)
BIB_RUN = bibtex $(ONAME)$(VENUE_SUFFIX).aux

default:
	$(TEX_RUN)
	@$(MAKE) bib
	$(TEX_RUN)
	$(TEX_RUN)
	$(TEX_RUN)
once:
	$(TEX_RUN)
bib:
	$(BIB_RUN)
ifeq ($(VENUE),aamas)
	perl -pe 's/(\\bibitem\[\\protect\\citeauthoryear\{Conitzer)/\\balance\n$$1/' $(ONAME)-aamas-orig.bbl > $(ONAME)-aamas.bbl
endif
clean:
	rm -f *.{aux,bbl,blg,log,out,toc,vtc,cut}
test:
	@echo COLOR: "$(COLOR)"
	@echo VENUE: "$(VENUE)"
	@printf '%s\n' 'ISPEC: $(ISPEC)'
	@printf '%s\n' 'TEX_RUN: $(TEX_RUN)'
	@printf '%s\n' 'BIB_RUN: $(BIB_RUN)'

arxiv:
	mkdir -p arxiv
	cp -r figs dags arxiv
	cp $(ONAME).bbl arxiv/$(ONAME)-final.bbl
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME).tex --bbl-to-link $(ONAME)-final.bbl -o arxiv/$(ONAME)-final.tex
	@echo "Now cd to arxiv and run 'pdflatex $(ONAME)-final.tex' thrice."
arxiv.zip: arxiv
	cd arxiv && zip -r ../arxiv.zip . $(ZIP_EXCLUDES)
camred:
	mkdir -p camred
	cp -r figs dags camred
	cp aamas.cls by.pdf camred
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME)-aamas.tex --bbl-to-read $(ONAME)-aamas.bbl -o camred/$(ONAME)-aamas-final.tex
	@echo "Now cd to camred and run 'pdflatex $(ONAME)-aamas-final.tex' thrice."
camred.zip: camred
	cd camred && zip -r ../camred.zip . $(ZIP_EXCLUDES)
