clean:
	rm *.aux \
	*.fdb_latexmk \
	*.fls \
	*.log \
	*.out \
	*.synctex.gz \
	*.toc \
	*.snm \
	*.nav

build:
	latexmk -xelatex -synctex=1 -jobname=diploma index.tex