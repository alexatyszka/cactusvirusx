MS = cvx-cactaceae
BIB = cvx-refs
# SI =
# CL =
# https://skim-app.sourceforge.io
# SKIM = /Applications/Skim.app/Contents/SharedSupport/displayline

OS := $(shell uname -s)
ifeq ($(OS),Linux)
	OS=linux
endif
ifeq ($(OS),Darwin)
	OS=osx
endif

all: ${MS}.pdf

cvx-cactaceae.pdf: ${MS}.tex ${BIB}.bib
	pdflatex ${MS}
	bibtex ${MS}
	pdflatex ${MS}
	pdflatex ${MS}

# cvx-cactaceae-si.pdf: ${SI}.tex ${MS}-refs.bib
# 	pdflatex ${SI}
# 	# Supp. Info. contains no references, bibtex freaks out.
# 	# bibtex ${SI}
# 	pdflatex ${SI}
# 	pdflatex ${SI}

# cvx-cactaceae-cover-letter.pdf: ${CL}.tex
# 	pdflatex ${CL}
# 	pdflatex ${CL}
# 	pdflatex ${CL}

krms: ${MS}.tex ${BIB}.bib
	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${MS}
	bibtex ${MS}
	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${MS}
	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${MS}
# 	${SKIM} -r 1 ${MS}.pdf ${MS}.tex

# krsi: ${SI}.tex ${BIB}.bib
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${SI}
# 	# Supp. Info. contains no references, bibtex freaks out.
# 	# bibtex ${SI}
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${SI}
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${SI}
# # 	${SKIM} -r 1 ${SI}.pdf ${SI}.tex

# krcl: ${CL}.tex
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${CL}
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${CL}
# 	pdflatex -synctex=1 -interaction=nonstopmode -halt-on-error ${CL}
# 	${SKIM} -r 1 ${CL}.pdf ${CL}.tex

kr: krms

clean:
	rm -f \
	*.bbl *.blg *.log *.aux *.toc *.fff *.ent *.ttt *.out *.fls \
	*.fdb_latexmk *.efsuppfigure *.efsupptable \
	*.dvi *.ps *.brf *.lof *.lot \
	*converted-to.pdf *.tex~ README.html \
	*-diff.tex

# For a satisfying, deep clean use scrub!
scrub: clean
	rm -f ${MS}.pdf ${SI}.pdf ${CL}.pdf \
	*.synctex.gz \
	.DS_Store .Rapp.history .Rhistory \
	*-diff.pdf *-kr-*.pdf
