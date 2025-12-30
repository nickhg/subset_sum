t1=> $@.tmp
t2=mv $@.tmp $@

TGTS=nums.sobj indices.sobj nums.subset.sobj defn.md defn.pdf sum.subset.sobj

NUM_NUMS=100
SUBSET_SIZE=50
MAX_NUM=1000

all: $(TGTS)

nums.sobj:
	sage -c "numbers = [randint(0, $(MAX_NUM)) for i in range($(NUM_NUMS))]; save(numbers, '$@')"

indices.sobj:
	sage -c "import random; indices = random.sample(range($(NUM_NUMS)), $(SUBSET_SIZE)); save(sorted(indices), '$@')"

nums.subset.sobj: nums.sobj indices.sobj
	sage -c "[nums,inds] = [load(sobj) for sobj in '$^'.split()]; save([nums[i] for i in inds], '$@')"

sum.subset.sobj: nums.subset.sobj
	sage -c "s=sum(load('$<')); save(s%$(MAX_NUM), '$@')"

defn.md: defn.template.md nums.sobj
	./gen_defn.sage $^ $(t1)
	$(t2)

# this reduces amount of typing needed
%.sobjP: %.sobj
	@sage -c "obj = load('$(<)'); print(obj)"

# e.g. make view FILE=nums.sobj
view:
	@sage -c "obj = load('$(FILE)'); print(obj)"

# pdfs can be opened with xdg-open
# pandoc can output to tex if desired, which can be hand-edited before the pdf is created
%.pdf: %.md
	pandoc $< -o $@ --pdf-engine=xelatex -V geometry:margin=1in

clean:
	rm -f $(TGTS) *.sage.py

