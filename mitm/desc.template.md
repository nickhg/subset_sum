# Meet-in-the-middle Enumeration

The idea of meet in the middle enumeration is that if

$$
\sum_{j=1}^{m} L_{i_j} = T \mod{N}
$$

then we can split the indices in half

$$
\sum_{j=1}^{m/2} L_{i_j} = x \mod{N}
$$

$$
\sum_{j=1}^{m/2} L_{i_{m/2+j}} = T-x \mod{N}
$$

So we only need to enumerate over every possible half-subset, and store in boxes $x$ and $T-x$.

TARGET = @@target mod @@modulus

NUM_POSSIBLE_HALF_SUBSETS = $\binom{@@num_nums}{@@half_num_summed}$ = @@num_subsets

We can filter for actual collisions

\begin{verbatim}
COLLISIONS = @@lookup
\end{verbatim}

And the complexity can be estimated by the first collision, which in this case is:

SMALLEST = @@smallest

Note that at most we will have to do $\binom{@@num_nums}{@@half_num_summed}$ work, but the expected amount of work is:

EXPECTED_WORK = $\binom{@@num_nums}{@@half_num_summed}/\sqrt{\binom{@@num_summed}{@@half_num_summed}}$ = @@expected_work




