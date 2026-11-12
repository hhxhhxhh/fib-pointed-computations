#!/bin/sh
set -eu
cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
if [ -n "${WOLFRAM_KERNEL:-}" ]; then
  kernel=$WOLFRAM_KERNEL
else
  kernel=$(command -v WolframKernel || true)
fi
if [ -z "$kernel" ] || [ ! -x "$kernel" ]; then
  echo "Set WOLFRAM_KERNEL to an executable WolframKernel." >&2
  exit 1
fi
actual=$(mktemp "${TMPDIR:-/tmp}/fib-pointed-checks.XXXXXX")
trap 'rm -f "$actual"' EXIT HUP INT TERM
for script in verify_explicit_two_dimensional_modules.wl verify_two_fib_arithmetic.wl verify_jellyfish_coefficients.wl; do
  if ! "$kernel" -noprompt -script "$script" >> "$actual" 2>&1; then
    cat "$actual"
    exit 1
  fi
done
cat "$actual"
diff -u EXPECTED_OUTPUT.txt "$actual"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum -c SHA256SUMS
else
  shasum -a 256 -c SHA256SUMS
fi
echo "All exact checks and ancillary hashes passed."
