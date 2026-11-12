Exact algebraic checks for the manuscript under review

The three Wolfram Language scripts and EXPECTED_OUTPUT.txt are copied without
changes from the manuscript's reproducibility materials. The scripts were
originally validated using Wolfram Language 14.3.0 for macOS ARM. Their original
Section 5 comments refer to arguments now in Appendix A.

These checks are optional and are not run when compiling main.tex.
They verify the matrix, arithmetic and scalar identities described in the
paper; they do not check the diagrammatic or categorical proofs.

To run all scripts and compare the complete output, set WOLFRAM_KERNEL to
your local WolframKernel executable if it is not available on PATH:

  WOLFRAM_KERNEL=/path/to/WolframKernel sh run_checks.sh

The runner can be invoked from any working directory. It requires a Wolfram
Language installation, diff and either sha256sum or shasum. It does not require
any files outside this ancillary directory, other than those system tools.
