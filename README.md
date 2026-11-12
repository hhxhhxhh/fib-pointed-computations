# Exact checks for tensor-category composites

Anonymous computational supplement for the manuscript under review. This package contains three Wolfram Language scripts, expected output and a runner for the exact matrix, arithmetic and scalar checks described in the manuscript.

## Run all checks

Requirements: an activated **Wolfram Language** installation providing `WolframKernel`, a POSIX shell, `diff`, and either `sha256sum` or `shasum`. Tested with Wolfram Language **14.3.0 on macOS ARM64**; no additional Wolfram packages are required.

Download and extract the anonymous repository archive. From its top-level directory, run:

```sh
WOLFRAM_KERNEL=/path/to/WolframKernel sh ancillary/run_checks.sh
```

If `WolframKernel` is already on `PATH`, use `sh ancillary/run_checks.sh`.
The runner compares the entire combined output with `EXPECTED_OUTPUT.txt` and checks `ancillary/SHA256SUMS`. It exits with a nonzero status on failure. Success ends with:

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

## Verification and integrity

The `verification/2026-11-12/` directory contains the verification output and environment record. `PROVENANCE.json` records the immutable computational inputs without identifying their authors. `MANIFEST_SHA256.json` contains hashes for all files in this snapshot except itself. Documentation has been anonymized and its hashes recomputed; the three scripts, expected output and shell runner are unchanged.
