GIT_ROOT := $(shell git rev-parse --show-toplevel)
include $(GIT_ROOT)/share.mk

include $(GIT_ROOT)/params.mk

TGTS=dict.sobj desc.md desc.pdf smallest.sobj filtered.sobj

all: $(TGTS)

include $(GIT_ROOT)/shared_rules.mk

# Subsets(4,2) returns
# [[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]]
comb_vectors.sobj:
	sage -c "vectors = [[1 if i in subset else 0 for i in range($(NUM_NUMS))] for subset in Subsets(range($(NUM_NUMS)), $(SUBSET_SIZE))]; save(vectors, '$@')"

# (N N/4) / sqrt((N/2 N/4))
# the time counter simulates taking a random subset, i.e. not in the order given by Subsets
dict.sobj: ../nums.sobj ../sum.subset.sobj
	sage -c "$(DICT_PY)"

define DICT_PY
import random; \
from collections import defaultdict; \
nums = load('$<'); \
target = load('$(d2)'); \
data1 = [ [sum(nums[i] for i in subset)%$(MAX_NUM), subset] for subset in Subsets(range($(NUM_NUMS)), $(SUBSET_SIZE)/2)]; \
data2 = [ [(target+$(MAX_NUM)-(sum(nums[i] for i in subset)%$(MAX_NUM)))%$(MAX_NUM), subset] for subset in Subsets(range($(NUM_NUMS)), $(SUBSET_SIZE)/2)]; \
time_counter = list(range(len(data1))); \
random.shuffle(time_counter); \
with_ctr1 = [ [v[0], [time_counter[i],v[1]]] for i, v, in enumerate(data1)]; \
with_ctr2 = [ [v[0], [time_counter[i],v[1]]] for i, v, in enumerate(data2)]; \
lookup = defaultdict(list); \
[lookup[k].append(v) for k, v in (with_ctr1+with_ctr2)]; \
save(dict(lookup),'$@')
endef

filtered.sobj: dict.sobj
	sage -c "lookup=load('$<'); save({k:v for k, v in lookup.items() if len(v) > 1},'$@')";

smallest.sobj: filtered.sobj
	sage -c "$(SMALLEST_PY)"

define SMALLEST_PY
lookup = load('$<'); \
min_key = min(lookup.keys(), key=lambda k: max(pair[0] for pair in lookup[k])); \
save(lookup[min_key],'$@')
endef

desc.md: desc.template.md filtered.sobj ../sum.subset.sobj smallest.sobj
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
smallest = load('$(d4)'); \
num_subsets = binomial($(NUM_NUMS),$(SUBSET_SIZE)/2); \
expected_work = (binomial($(NUM_NUMS),$(SUBSET_SIZE)/2)/sqrt(binomial($(SUBSET_SIZE),$(SUBSET_SIZE)/2))).n(); \
pretty_lookup = pformat_truncated(lookup, first=10, last=10, width=80); \
md_contents=template.substitute(target=target, modulus=$(MAX_NUM), \
lookup=pretty_lookup, smallest = smallest, num_subsets = num_subsets, \
num_summed = $(SUBSET_SIZE), half_num_summed = $(SUBSET_SIZE)/2, \
expected_work = expected_work, num_nums = $(NUM_NUMS)); \
print(md_contents)
endef

clean:
	rm -f $(TGTS)
