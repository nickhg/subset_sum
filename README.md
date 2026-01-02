# Subset Sum Analysis

Research exploring practical implementations of subset sum algorithms, including meet-in-the-middle techniques and the representation method from [Howgrave-Graham & Joux, EUROCRYPT 2010](http://eprint.iacr.org/2010/189).

## PDFs

📄 [The Subset Sum Problem (PDF)](https://github.com/nickhg/subset_sum/blob/main/releases/subset_sum.pdf)
📄 [Brute Force (PDF)](https://github.com/nickhg/subset_sum/blob/main/releases/brute_force.pdf)
📄 [Meet-in-the-middle (PDF)](https://github.com/nickhg/subset_sum/blob/main/releases/mitm.pdf)

## Status

Work in progress - computational experiments and analysis.

## Building
```bash
# Generate a new challenge problem and the top level problem description
make clean all

# Do the brute-force technique and generate the description
make -C brute_force clean all

# Do the MITM technique and generate the description
make -C mitm clean all
```

## References

See `references.bib` for cited works.

## Contact

Nick Howgrave-Graham - [LinkedIn](https://www.linkedin.com/in/nick-howgrave-graham-1462148/)

For questions or discussion, please [open an issue](https://github.com/nickhg/subset_sum/issues).