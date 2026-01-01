
# this reduces amount of typing needed
%.sobjP: %.sobj
	@sage -c "obj = load('$(<)'); print(obj)"

%.sobjD: %.sobj
	@rm $<
	$(MAKE) $<

# e.g. make view FILE=nums.sobj
view:
	@sage -c "obj = load('$(FILE)'); print(obj)"

PANDOC_FLAGS = --pdf-engine=xelatex \
-V geometry:margin=1in \
--bibliography=$(BIBLIOGRAPHY) \
--csl=$(CSL_STYLE) \
--citeproc \
-V colorlinks=true \
-V linkcolor=blue \
-V urlcolor=blue \
-V citecolor=blue
# the following ones are commented out \
--number-sections \
--toc \
--toc-depth=2 \

# pdfs can be opened with xdg-open
# pandoc can output to tex if desired, which can be hand-edited before the pdf is created
%.pdf: %.md
	pandoc $< -o $@ $(PANDOC_FLAGS)

