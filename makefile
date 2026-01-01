GIT_ROOT := $(shell git rev-parse --show-toplevel)
include $(GIT_ROOT)/share.mk

TGTS=nums.sobj indices.sobj nums.subset.sobj defn.md defn.pdf sum.subset.sobj

include params.mk

all: $(TGTS)

include shared_rules.mk

nums.sobj:
	sage -c "numbers = [randint(0, $(MAX_NUM)) for i in range($(NUM_NUMS))]; save(numbers, '$@')"

indices.sobj:
	sage -c "import random; indices = random.sample(range($(NUM_NUMS)), $(SUBSET_SIZE)); save(sorted(indices), '$@')"

nums.subset.sobj: nums.sobj indices.sobj
	sage -c "[nums, inds] = [load(sobj) for sobj in '$^'.split()]; save([nums[i] for i in inds], '$@')"

sum.subset.sobj: nums.subset.sobj
	sage -c "s=sum(load('$<')); save(s%$(MAX_NUM), '$@')"

# for simply py scripts that use no whitespace we can embed the code here
# (more complex scripts should be standalone .sage files)
defn.md: defn.template.md nums.sobj sum.subset.sobj
	sage -c "import sys; \
from pprint import pprint, pformat; \
from mytemplate import MyTemplate; \
from string import Template; \
template = MyTemplate(open('$<').read()); \
nums = load('$(d2)'); \
target = load('$(d3)'); \
pretty_nums = pformat(nums, width=80, compact=True); \
md_contents=template.substitute(target=target, modulus=$(MAX_NUM), \
	list_size=$(NUM_NUMS), num_summed=$(SUBSET_SIZE), the_list=pretty_nums); \
print(md_contents)" $(t1)
	$(t2)

clean:
	rm -f $(TGTS)
	make -C brute_force clean

