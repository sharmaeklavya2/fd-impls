# This file must be run with GNU make
# Example invocations:
# make
# make VENUE=aij PART=2 COLOR=dark once
# make VENUE=aij bib

INAME = main
ONAME = fimp
OUT_DIR = build
TEX_OPTIONS = -cnf-line "max_print_line = 10000" -halt-on-error
ZIP_EXCLUDES = -x '.*' -x '*.db' -x '__MACOSX'

PART ?= 1
VENUE ?= aij

VENUE_SUFFIX = $(if $(VENUE),$(PART)-$(VENUE),$(PART))
BUILD_PREFIX = $(if $(OUT_DIR),$(OUT_DIR)/)
AUX_BASE = $(BUILD_PREFIX)$(ONAME)$(VENUE_SUFFIX)
ISPEC = $(if $(COLOR),"\def\colorscheme{$(COLOR)}\input{$(INAME)$(VENUE_SUFFIX).tex}",$(INAME)$(VENUE_SUFFIX).tex)
TEX_RUN = pdflatex $(TEX_OPTIONS) -jobname=$(ONAME)$(VENUE_SUFFIX) $(if $(OUT_DIR),-output-directory=$(OUT_DIR) )$(ISPEC)
BIB_RUN = bibtex $(AUX_BASE).aux

default:
	$(if $(OUT_DIR),mkdir -p $(OUT_DIR))
	$(TEX_RUN)
	$(BIB_RUN)
	$(TEX_RUN)
	$(TEX_RUN)
	$(TEX_RUN)
once:
	$(if $(OUT_DIR),mkdir -p $(OUT_DIR))
	$(TEX_RUN)
bib:
	$(BIB_RUN)

clean:
	rm -f $(BUILD_PREFIX)*.{aux,bbl,blg,log,out,toc,vtc,cut}
test:
	@echo COLOR: "$(COLOR)"
	@echo VENUE: "$(VENUE)"
	@printf '%s\n' 'ISPEC: $(ISPEC)'
	@printf '%s\n' 'TEX_RUN: $(TEX_RUN)'
	@printf '%s\n' 'BIB_RUN: $(BIB_RUN)'

camred:
	mkdir -p camred
	cp -r figs dags camred
	cp aamas.cls by.pdf camred
	# https://github.com/sharmaeklavya2/tex-flatten
	tex-flatten.py $(INAME)-aamas.tex --bbl-to-read $(AUX_BASE).bbl -o camred/$(ONAME)-aamas-final.tex
	@echo "Now cd to camred and run 'pdflatex $(ONAME)-aamas-final.tex' thrice."
camred.zip: camred
	cd camred && zip -r ../camred.zip . $(ZIP_EXCLUDES)
