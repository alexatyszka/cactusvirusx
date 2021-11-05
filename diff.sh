#!/usr/bin/env bash

BASE_NAME="cvx-cactaceae-kr-2021-10-28"

latexmk -pdf $BASE_NAME

# xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME
# bibtex8 $BASE_NAME
# xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME
# xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME

latexdiff cvx-cactaceae.tex $BASE_NAME.tex > $BASE_NAME-diff.tex

xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME-diff
bibtex8 $BASE_NAME-diff
xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME-diff
xelatex -8bit -synctex=0 -interaction=nonstopmode $BASE_NAME-diff

# make clean
