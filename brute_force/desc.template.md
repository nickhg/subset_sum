# Brute Force Enumeration

The idea of brute force enumeration is to simply enumerate over every possible subset, and check if the sum is equal to the target sum.

TARGET = @@target mod @@modulus

NUM_POSSIBLE_SUBSETS = $\binom{@@num_nums}{@@num_summed}$ = @@num_subsets

If we precompute all the sums in this fashion:

\begin{verbatim}
THE_DICTIONARY = @@lookup
\end{verbatim}

then we can simply look up the answer based on dictionary index

SOLUTIONS = @@solutions

**Notes:**

* early exit (rather than full enumeration) would have entailed a little less computation, but we should not expect to find the answer if we enumerate a significantly smaller set.
* the solutions are a list, because in theory there could be more than one answer, and this becomes more likely as the modulus is decreased


