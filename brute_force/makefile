GIT_ROOT := $(shell git rev-parse --show-toplevel)
include $(GIT_ROOT)/share.mk

include $(GIT_ROOT)/params.mk

TGTS=dict.sobj solution.sobj desc.md desc.pdf

all: $(TGTS)

include $(GIT_ROOT)/shared_rules.mk

# Subsets(4,2) returns
# [[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]]
comb_vectors.sobj:
	sage -c "vectors = [[1 if i in subset else 0 for i in range($(NUM_NUMS))] for subset in Subsets(range($(NUM_NUMS)), $(SUBSET_SIZE))]; save(vectors, '$@')"

dict.sobj: ../nums.sobj
	sage -c "$(DICT_PY)"

# Subsets() returns an iterator, rather than the full output
# The iterator can be sliced/chunked as necessary if binomial($(NUM_NUMS), $(SUBSET_SIZE) is too large to fit into memory
# (though dont currently have code to further support this pattern)
MAX_CHUNK=10000000
CHUNK_START=0
CHUNK_END=$(MAX_CHUNK)
# When an object from Subsets() is instantiated it is a "fat" object, so it is cast to a simple tuple as soon as possible
define DICT_PY
from collections import defaultdict; \
from itertools import islice; \
nums = load('$<'); \
\
''' Error out if the number of subsets is too large for exhaustive search'''; \
\
num_subsets=binomial($(NUM_NUMS),$(SUBSET_SIZE)); \
err_msg=f'The number of subsets is above threshold MAX_CHUNK: {num_subsets} > $(MAX_CHUNK) \
\nPlease consider increasing this if you have the memory to spare'; \
assert num_subsets <= $(MAX_CHUNK), err_msg; \
\
''' Sage math Subset elements take up way more memory that tuples, so we cast to tuples as soon as possible'''; \
\
lookup = defaultdict(list); \
[lookup[sum(nums[i] for i in subset)%$(MAX_NUM)].append(tuple(subset)) \
  for subset in islice(Subsets(range($(NUM_NUMS)), $(SUBSET_SIZE)), $(CHUNK_START), $(CHUNK_END))]; \
save(dict(lookup),'$@')
endef

solution.sobj: dict.sobj ../sum.subset.sobj
	sage -c "[lookup, target] = [load(sobj) for sobj in '$^'.split()]; save(lookup[target], '$@')"

desc.md: desc.template.md dict.sobj ../sum.subset.sobj solution.sobj
	sage -c "$(DESC_PY)" $(t1)
	$(t2)

define DESC_PY	
import sys; \
from mypprint import pformat_truncated; \
from mytemplate import MyTemplate; \
from string import Template; \
template = MyTemplate(open('$<').read()); \
lookup = load('$(d2)'); \
target = load('$(d3)'); \
solutions = load('$(d4)'); \
num_subsets = binomial($(NUM_NUMS),$(SUBSET_SIZE)); \
pretty_lookup = pformat_truncated(lookup, first=10, last=10, width=80); \
md_contents=template.substitute(target=target, modulus=$(MAX_NUM), \
	lookup=pretty_lookup, solutions = solutions, num_subsets = num_subsets, \
	num_summed = $(SUBSET_SIZE), num_nums = $(NUM_NUMS)); \
print(md_contents)
endef

clean:
	rm -f $(TGTS)
