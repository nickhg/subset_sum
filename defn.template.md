
<!-- this is a markdown file to explain the subset sum problem -->

<!-- blank lines are new paragraphs -->

<!-- use #, ##, ### for headings -->

---
#title: "Subset Sum Analysis"
#author: "Nick Howgrave-Graham"
#date: "January 2026"
#bibliography: /home/nickhg/git/subset_sum/references.bib
#csl: /home/nickhg/git/subset_sum/ieee.csl
---

# The Subset Sum Problem

The subset sum problem is the following: you are given a target number, and a modulus like this:

<!-- patterns of the form two @'s, followed by a variable name will undergo substitution -->

TARGET = @@target mod @@modulus

<!-- use _a_ for italic, and **a** for bold -->

and told that the target number is the sum of some number of elements from a _public_ list of numbers:

LIST_SIZE = @@list_size

NUM_SUMMED = @@num_summed

<!-- the list is formatted regardless of its pretty printing, but pretty printing might be good for reading md file -->

THE_LIST = @@the_list

The problem is to identify which of the listed numbers were summed, i.e. create a list of indices of size NUM_SUMMED
for which

$$
\sum_{j=1}^{m} L_{i_j} = T \mod{N}
$$

where $T,N,L,m$ are the target, modulus, list and num_summed, respectively.

## Notes

The subset sum problem has a rich history. Some observations are:

* If the modulus is small, then there could be multiple solutions. We'll mostly be interested in the case when the elements of the list cannot be easily distinguished from random, and where the modulus is large enough for it to be very likely that there is only one solution.
* When NUM_SUMMED = LIST_SIZE/2 the number of possible subsets is maximized
* If NUM_SUMMED > LIST_SIZE/2, one would consider the items that are _not_ in the sum, since the sum of all the numbers is public.
* If NUM_SUMMED is not provided, it is not too hard to enumerate over every possible NUM_SUMMED <= LIST_SIZE
* The subset sum problem was shown to be NP-complete by Karp [@karp1972reducibility], 
building on Cook's foundational work on NP-completeness [@cook1971complexity]. See also 
[@garey1979computers].

## References

<!-- markdown can also display matrices within round parentheses, square brackets, or straight lines -->
<!-- \begin{pmatrix} a & b \\ c & d \end{pamtrix}, or bmatrix, vmatrix -->
