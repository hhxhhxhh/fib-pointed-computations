# Fibonacci–pointed composite computations

Computational companion to **Huixuan He and Zhengwei Liu, _Finite Composites of the Fibonacci Category with Pointed Fusion Categories_**, [arXiv:2610.41891](https://arxiv.org/abs/2610.41891).

This repository provides three Wolfram Language scripts for the paper's exact matrix, arithmetic and scalar checks, together with expected output and a runner that checks both the output and file hashes.

## Obtain the code

- **arXiv:** open [the paper](https://arxiv.org/abs/2610.41891) and choose **TeX Source**, or [download the source archive directly](https://arxiv.org/src/2610.41891). The computational files are in `anc/`.
- **GitHub:** clone this repository as below, or choose **Code → Download ZIP**. The computational files are in `ancillary/`.

The three scripts, expected output and shell runner are byte-for-byte identical to the arXiv source retrieved on 2026-11-12. The ancillary README clarifies the run instructions and current appendix numbering; its checksum list is updated accordingly. [PROVENANCE.json](PROVENANCE.json) records the correspondence and hashes.

## Run all checks

Requirements: an activated **Wolfram Language** installation providing `WolframKernel`, a POSIX shell, `diff`, and either `sha256sum` or `shasum`. The scripts were tested with Wolfram Language **14.3.0 on macOS ARM64**. No additional Wolfram packages are needed. Wolfram software is not included in this repository.

```sh
git clone https://github.com/hhxhhxhh/fib-pointed-computations.git
cd fib-pointed-computations
WOLFRAM_KERNEL=/path/to/WolframKernel sh ancillary/run_checks.sh
```

If `WolframKernel` is already on `PATH`, use `sh ancillary/run_checks.sh`. To run the arXiv copy instead, use `sh anc/run_checks.sh` from the extracted source directory, with the same `WOLFRAM_KERNEL` setting when needed.

The runner invokes the three scripts in a fixed order, compares their entire combined output with `EXPECTED_OUTPUT.txt`, and verifies `SHA256SUMS`. It exits with a nonzero status on failure. Success ends with:

```text
All exact checks and ancillary hashes passed.
```

## Contents and scope

| File in `ancillary/` | Checks |
|---|---|
| `verify_explicit_two_dimensional_modules.wl` | Quadratic matrix relations, trace and determinant, an odd Chebyshev identity, and braid identities for the listed finite parameters |
| `verify_two_fib_arithmetic.wl` | Character sums for the listed parameters, candidate codegrees and minimal polynomials, selected integrality obstructions, and a totient search through 1000 |
| `verify_jellyfish_coefficients.wl` | Scalar coefficients, index permutations and Gram exponents for the n = 2 and n = 3 tables, and nonzero denominators for both Galois branches |
| `EXPECTED_OUTPUT.txt` | Complete expected combined output from the three scripts |
| `run_checks.sh`, `SHA256SUMS` | Execution, output comparison and integrity checks |

The scripts check the displayed algebraic identities and finite cases. They do not verify planar reductions, train independence, tadpole vanishing, categorical descent, or the general classification proof. The finite totient search does not establish an unbounded exclusion. Those arguments remain in the paper. Historical “Section 5” comments in the scalar script refer to material now in Appendix A. These computations are not a proof-assistant formalization.

## Verification and citation

[verification/2026-11-12/](verification/2026-11-12/) contains a fresh run of this repository's runner and its environment record. [MANIFEST_SHA256.json](MANIFEST_SHA256.json) binds all published files other than itself and Git metadata.

Please cite the paper for the mathematical results and include a repository commit URL when identifying the version of the code used.
